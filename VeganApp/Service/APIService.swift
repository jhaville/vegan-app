import Foundation

class APIService {
  func load<A>(resource: Resource<A>, completion: @escaping(Response<A>)) {
    URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
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
}

