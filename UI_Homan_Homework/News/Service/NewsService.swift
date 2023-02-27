

import Foundation
import WebKit
import RealmSwift
import Realm


let newsUrl = "https://api.vk.com/method/newsfeed.get"
let newsSettings = ["access_token": Session.instance.token,
                    "filters": "post",
                    "count": "30",
                    "v": "5.131"]


/// MARK: URLRequest news
public func newsGetRequests(completion: @escaping ([NewsPost]) -> Void) {
    var parsedItems = [NewsItem]()
    var parsedProfiles = [NewsProfiles]()
    var parsedGroups = [NewsGroups]()
    
    guard let url = NetworkManager.getRequest(url: newsUrl, settings: newsSettings) else {return}
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data,
              let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any],
              let response = (json["response"] as? [String: Any]) else {return}
        
        let itemsData = (try? JSONSerialization.data(withJSONObject: (response["items"]) as Any, options: .fragmentsAllowed)) ?? Data()
        let profilesData = (try? JSONSerialization.data(withJSONObject: (response["profiles"]) as Any, options: .fragmentsAllowed)) ?? Data()
        let groupsData = (try? JSONSerialization.data(withJSONObject:  (response["groups"]) as Any, options: .fragmentsAllowed)) ?? Data()
        
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
            completion(newsPostItems)
        }
    }.resume()
}


public func newsAvatarGetRequests(news: [NewsPost], completion: @escaping ([NewsPost]) -> Void) {
    for item in news {
        UIImage.loadFrom(stringURL: item.avatarURL) { image in
            item.avatarImage = image ?? UIImage()
        }
    }
    for item in news {
        for photo in item.photosURL {
            UIImage.loadFrom(stringURL: photo) { image in
                item.photosImage.append(image)
            }
        }
    }
    completion(news)
}

func mapItemsToNewsPost(itemsNews: [NewsItem], profilesNews: [NewsProfiles], groupsNews: [NewsGroups]) -> [NewsPost]{
    let newsPost = itemsNews.map {  item in
        let news = NewsPost()
        
        if item.sourceID < 0 {
            let group = groupsNews.first(where: {$0.id == (-item.ownerID)})
            news.namePersonOrGroupId = group?.name ?? ""
            news.avatarURL = group?.avatarURL ?? ""
        } else {
            let profile = profilesNews.first(where: {$0.id == item.sourceID})
            news.namePersonOrGroupId = ((profile?.firstName ?? "") + (profile?.lastName ?? ""))
            news.avatarURL = profile?.avatarURL ?? ""
        }
        news.idPost = item.sourceID
        news.textPost = item.text ?? ""
        if item.photosURL != nil {
            for photo in item.photosURL! {
                news.photosURL.append(photo)
            }
        }
        return news
    }
    return newsPost
}

