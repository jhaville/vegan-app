import Foundation

struct Resource<A: Decodable> {
    let url: URL
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL) {
        self.url = url
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
