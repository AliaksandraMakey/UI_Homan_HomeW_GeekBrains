
import Foundation
import UIKit


extension UIImage {
    public static func loadFrom(stringURL: String, completion: @escaping (_ image: UIImage?) -> ()) {
        
        guard let url = URL(string: stringURL) else { return }
        
        let  cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let imageData = cache.cachedResponse(for: request)?.data, let image = UIImage(data: imageData) {
            completion(image)
        } else {
            URLSession.shared.dataTask(with: url) { data, response,_ in
                guard let data = data,
                      let response = response
                else { return }
                let cacheResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cacheResponse, for: request)
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            }.resume()
        }
    }
}
