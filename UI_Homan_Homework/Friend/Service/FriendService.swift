
import Foundation
import WebKit
import RealmSwift
import Realm


let friendsUrl = "https://api.vk.com/method/friends.get"
var friendSettings = ["access_token": Session.instance.token,
                      "count": "20",
                      "fields": "bdate, photo_100",
                      "v": "5.131"]

/// MARK: URLRequest friendsID
public func friendsGetRequests() -> [Friend] {
    guard let url = NetworkManager.getRequest(url: friendsUrl, settings: friendSettings) else { return [Friend]()}
    
    let (data, _, _) = URLSession.shared.syncRequest(with: url)
    do {
         let json = data!
              let friendResponse = try JSONDecoder().decode( GetFriendResponse.self, from: json)
        let items = friendResponse.response.items
        let realmFriends = mapItemsToRealmFriends(itemFriends: items)
        saveFriends(items : realmFriends)
        return mapRealmsToFriends(realmFriends: realmFriends)
    } catch let error {
        print(error.localizedDescription)
        return [Friend]()
    }
  
}

/// MARK: saveFriends
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

/// MARK: mapFriendToRealmFriend
public func mapFriendToRealmFriend(friend: Friend) -> RealmFriends {
    let realmFriend = RealmFriends()
        realmFriend.id = friend.id
        realmFriend.lastName = friend.surName
        realmFriend.firstName = friend.firstName
        realmFriend.birthDayDate = friend.birthDayDate
        return realmFriend
    }

/// MARK: getAllRealmFriends
public func getAllRealmFriends() -> [RealmFriends] {
    do {
        let realm = try Realm()
        return realm.objects(RealmFriends.self).map{$0}
    } catch {
        print(error)
        return [RealmFriends]()
    }
}

/// MARK: mapRealmsToFriends
public func mapRealmsToFriends(realmFriends: [RealmFriends]) -> [Friend]{
    return realmFriends.map {  item in
        var friend = Friend(id: item.id)
        friend.firstName = item.firstName
        friend.surName = item.lastName
        friend.birthDayDate = item.birthDayDate
        friend.avatarPhoto = UIImage(data: item.data!) ?? UIImage()
        return friend
    }
}

/// MARK: mapItemsToRealmFriends
public func mapItemsToRealmFriends(itemFriends: [FriendItem]) -> [RealmFriends]{
    return itemFriends.map {  item in
        let realmFriends = RealmFriends()
        let url = URL(string: item.photo100 ?? "")
        let image = try? Data(contentsOf: url!)
        realmFriends.url = item.photo100 ?? ""
        realmFriends.data = image
        realmFriends.id = item.id
        realmFriends.firstName = item.firstName
        realmFriends.lastName = item.lastName
        realmFriends.birthDayDate = item.birthDay ?? ""
        return realmFriends
    }
}
