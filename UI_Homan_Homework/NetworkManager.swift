

import Foundation
import WebKit
import RealmSwift
import Realm

class NetworkManager {
    
    static func getRequest(url: String, settings: [String: String?])  -> URL?{
        guard let request = createRequest(url: url, settings: settings) else { return nil }
        return request
    }
    
    private static func createRequest(url: String, settings: [String: String?]) -> URL? {
        var components = URLComponents(string: url)
        var queryItems: [URLQueryItem] = []
        for (key, value) in settings {
            queryItems.insert(URLQueryItem(name: key, value: value), at: 0)
        }
        components?.queryItems = queryItems
        guard let url = components?.url else {return nil}
        return url
    }
    
}

extension URLSession {
    
    func syncRequest(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        let dispatchGroup = DispatchGroup()
        let task = dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()
        
        return (data, response, error)
    }
    
}
