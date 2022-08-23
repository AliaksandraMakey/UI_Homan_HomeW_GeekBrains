
import Foundation
import WebKit
import RealmSwift
import Realm

let token = Session.instance.token
let userID =  Session.instance.userId
let friendsUrl = "https://api.vk.com/method/friends.get"
let groupsUrl = "https://api.vk.com/method/groups.get"
let photoUrl = "https://api.vk.com/method/photos.getAll"
var friendSettings = ["access_token": token,
                      "count": "2",
                      "fields": "sex",
                      "v": "5.131"]

var groupSettings = ["access_token": token,
                     "count": "2",
                     "extended": "1",
                     "v": "5.131"]

var photoSettings = ["access_token": token,
                     "count": "2",
                     "photo_sizes": "1",
                     "v": "5.131"]
    
    /// MARK: URLRequest friendsID
    func friendsGetRequests() {
        let url = NetworkManager.getRequest(url: friendsUrl, settings: friendSettings)
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            guard
                let json = data,
                let friendResponse = try? JSONDecoder().decode( GetFriendResponse.self, from: json)
            else { return }
         print(data)
            let realmFriends: [RealmFriends] = friendResponse.response.items.map {  item in
            
                let realmFriends = RealmFriends()
                
                realmFriends.id = item.id
                realmFriends.firstName = item.firstName
                realmFriends.lastName = item.lastName
                
                return realmFriends
            }
            saveFriends(items : realmFriends)
        }.resume()
    }
private func saveFriends(items: [RealmFriends]) {
    do {
        let realm = try Realm()
        try realm.write {
            
            items.forEach { item in
                let obj = try? realm.object(ofType: RealmFriends.self, forPrimaryKey: item.id)
                    if obj == nil {
                        realm.add(item)
                    }
                }
            }
    } catch {
        print(error)
    }
}


    /// MARK: URLRequest groupsID
    func groupsGetRequests() {
        let url = NetworkManager.getRequest(url: groupsUrl, settings: groupSettings)
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            guard
                let json = data,
            let groupResponse = try? JSONDecoder().decode( GetGroupResponse.self, from: json)
            else { return }
                print(data)
            let realmGroups: [RealmGroups] = groupResponse.response.items.map { item in
                
                let realmGroups = RealmGroups()
                realmGroups.id = item.id
                realmGroups.name = item.name
                realmGroups.photoHundred = item.photoHundred
                
                return realmGroups
            }
            saveGroups(items : realmGroups)
        }.resume()
    }

private func saveGroups(items: [RealmGroups]) {
    do {
        let realm = try Realm()
        try realm.write {
            
            items.forEach { item in
                let obj = try? realm.object(ofType: RealmGroups.self, forPrimaryKey: item.id)
                    if obj == nil {
                        realm.add(item)
                    }
                }
            }
    } catch {
        print(error)
    }
}

    
    
    /// MARK: URLRequest photos
    func photosGetRequests() {
        let url =  NetworkManager.getRequest(url: photoUrl, settings: photoSettings)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard
                let json = data,
            let photoResponse = try? JSONDecoder().decode( GetPhotoResponse.self, from: json)
            else { return }
            print(data)
        let realmPhotos: [RealmPhotos] = photoResponse.response.items.map { item in
            
            let realmPhotos = RealmPhotos()
            realmPhotos.id = item.id
            realmPhotos.date = item.date
            realmPhotos.albumId = item.albumId
            realmPhotos.ownerId = item.ownerId
            
            return realmPhotos
        }
            savePhotos(items : realmPhotos)
        }.resume()
    }

private func savePhotos(items: [RealmPhotos]) {
    do {
        let realm = try Realm()
        try realm.write {

            items.forEach { item in
                let obj = try? realm.object(ofType: RealmPhotos.self, forPrimaryKey: item.id)
                    if obj == nil {
                        realm.add(item)
                    }
                }
            }
    } catch {
        print(error)
    }
}

