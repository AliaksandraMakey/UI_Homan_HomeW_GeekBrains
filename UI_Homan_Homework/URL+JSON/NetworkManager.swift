//
//  NetworkManager.swift
//  UI_Homan_Homework
//
//  Created by aaa on 17.08.22.
//

import Foundation

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
