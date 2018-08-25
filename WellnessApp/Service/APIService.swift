import Foundation
import CoreLocation

class APIService {
  func load<A>(resource: Resource<A>, completion: @escaping(Response<A>)) {
    URLSession.shared.dataTask(with: resource.urlRequest) { (data, response, error) in
      if let error = error {
        completion(error, nil)
        return
      }
      if let data = data, let result = resource.parse(data) {
        completion(nil, result)
      } else {
        completion(NSError(domain: "NoDataError", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: ["description": "no data"]), nil)
      }
      }.resume()
  }

  private func urlRequest(path: String,
                          urlParameters: [String: String],
                          body: [String: Any?] = [:],
                          restMethod: RestMethod = .get) -> URLRequest? {

    var urlComponents = URLComponents(string: BackendEnvironment.current().getBaseUrlString())
    urlComponents?.path = path
    urlComponents?.queryItems = urlParameters.map { URLQueryItem(name: $0.key, value: $0.value) }

    guard let url = urlComponents?.url else { return nil }

    var request = URLRequest(url: url)
    request.httpMethod = restMethod.rawValue
    request.httpBody = restMethod == .post ? try? JSONSerialization.data(withJSONObject: body as Any, options: .prettyPrinted) : nil

    return request
  }

  func itemRequest(location: CLLocation, cursor: Int, numOfItems: Int, itemType: ItemType) -> URLRequest? {
    return urlRequest(path: "/" + itemType.toCollectionName(), urlParameters:  ["lat": "\(location.coordinate.latitude)", "long": "\(location.coordinate.longitude)", "cursor": "\(cursor)", "num_of_items": "\(numOfItems)"])
  }

}

enum RestMethod: String {
  case get = "GET"
  case post = "POST"
}
