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


public func newsGetRequests() -> [NewsPost] {
    

        guard let url = NetworkManager.getRequest(url: newsUrl, settings: newsSettings) else {return [NewsPost]()}
        let (data, _, _) = URLSession.shared.syncRequest(with: url)
        
        guard let json = data,
              let newsResponse = try? JSONDecoder().decode(GetNewsResponse.self, from: json) else {return [NewsPost]()}
    guard let items = newsResponse.response.items else {return [NewsPost]()}
    guard let profiles = newsResponse.response.profiles else {return [NewsPost]()}
    guard let groups = newsResponse.response.groups else {return [NewsPost]()}

    return mapItemsToNewsPost(itemsNews: items, profilesNews: profiles, groupsNews: groups)
}

public func mapItemsToNewsPost(itemsNews: [NewsItem], profilesNews: [NewsProfiles], groupsNews: [NewsGroups]) -> [NewsPost]{
    
    let newsPost = itemsNews.map {  item in
        var news = NewsPost()
        if item.sourceId < 0 {
//            var groupsNewsWithPositiveId = groupsNews.
            if let group = groupsNews.first(where: {$0.id == (-item.sourceId)}){
                news.namePersonOrGroupId = group.name ?? "No name"
                //                news.photoTitlePersonOrGroup = group.photo100
            }
        } else {
                if let profile = profilesNews.first(where: {$0.id == item.sourceId}){
//                     let name = (profile.firstName ?? "No name") + (profile.lastName ?? "No name")
                    news.namePersonOrGroupId = (profile.firstName ?? "No name")
//                news.photoTitlePersonOrGroup = profile.photo100
            }
        }
        news.idPost = item.sourceId
        news.postType = item.postType ?? ""
        news.textPost = item.text ?? ""
        
        return news
    }

    return newsPost
}

