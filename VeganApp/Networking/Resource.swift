import Foundation

struct Resource<A: Decodable> {
    let urlRequest: URLRequest
    let parse: (Data) -> A?
}

extension Resource {
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        self.parse = { data in
            let decoder = JSONDecoder()
            do {
                try decoder.decode(A.self, from: data)
            } catch {
                print(error)
            }
            return try? decoder.decode(A.self, from: data)
        }
    }
}

typealias Response<A> = (Error?, A?) -> Void
