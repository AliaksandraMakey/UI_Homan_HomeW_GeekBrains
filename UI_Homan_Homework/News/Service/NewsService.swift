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


public func newsGetRequests(complitionHandler: @escaping ([NewsPost]) -> Void) {
    DispatchQueue.global().async {
        guard let url = NetworkManager.getRequest(url: newsUrl, settings: newsSettings) else {return }
        let (data, _, _) = URLSession.shared.syncRequest(with: url)
        
        var parsedItems = [NewsItem]()
        var parsedProfiles = [NewsProfiles]()
        var parsedGroups = [NewsGroups]()
        
        let json = (try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    as? [String: Any]) ?? [:]
        let response = (json["response"] as? [String: Any]) ?? [:]
        let itemsJson = response["items"]
        let profilesJson = response["profiles"]
        let groupsJson = response["groups"]
        
        let itemsData = (try? JSONSerialization.data(withJSONObject: itemsJson as Any, options: .fragmentsAllowed)) ?? Data()
        let profilesData = (try? JSONSerialization.data(withJSONObject: profilesJson as Any, options: .fragmentsAllowed)) ?? Data()
        let groupsData = (try? JSONSerialization.data(withJSONObject: groupsJson as Any, options: .fragmentsAllowed)) ?? Data()
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        DispatchQueue.global().async {
            let model = try? JSONDecoder().decode([NewsItem].self, from: itemsData)
            parsedItems = model ?? []
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async {
            let model = try? JSONDecoder().decode([NewsProfiles].self, from: profilesData)
            parsedProfiles = model ?? []
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async {
            let model = try? JSONDecoder().decode([NewsGroups].self, from: groupsData)
            parsedGroups = model ?? []
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global()) {
            let newsPostItems = mapItemsToNewsPost(itemsNews: parsedItems, profilesNews: parsedProfiles, groupsNews: parsedGroups)
            complitionHandler(newsPostItems)
        }
    }
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

