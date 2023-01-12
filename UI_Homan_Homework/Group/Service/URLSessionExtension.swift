
import Foundation

extension URLSession {
    func request(url: URL) -> Future<Data> {
        let promise = Promise<Data>()
        
        dataTask(with: url) { data, _, error in
            if let error = error {
                promise.reject(with: error)
            } else {
                promise.result(with: data ?? Data())
            }
        }.resume()
        
        return promise
    }
}
