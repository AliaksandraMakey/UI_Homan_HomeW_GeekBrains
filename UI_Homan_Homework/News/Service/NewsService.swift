//
//  NewsSwrvice.swift
//  UI_Homan_Homework
//
//  Created by aaa on 10.11.22.
//

import Foundation
import WebKit
import RealmSwift
import Realm

let newsUrl = "https://api.vk.com/method/newsfeed.get"
let newsSettings = ["access_token": Session.instance.token,
                    "filters": "post",
                    "count": "10",
                    "v": "5.131"]

/// MARK: URLRequest news

func newsGetRequests() {
    guard let url = NetworkManager.getRequest(url: newsUrl, settings: newsSettings) else {return}
    let (data, _, _) = URLSession.shared.syncRequest(with: url)
    
    guard let json = data,
          let newsResponse = try? JSONDecoder().decode(GetNewsResponse.self, from: json) else {return}
    let items = newsResponse.response.items
    let profiles = newsResponse.response.profiles
    let groups = newsResponse.response.groups
}
