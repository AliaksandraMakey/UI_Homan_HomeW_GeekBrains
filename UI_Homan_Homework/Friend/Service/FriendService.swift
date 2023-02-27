
import Foundation
import WebKit
import RealmSwift
import Realm


let friendsUrl = "https://api.vk.com/method/friends.get"
var friendSettings = ["access_token": Session.instance.token,
                      "count": "5",
                      "fields": "bdate, photo_100",
                      "v": "5.131"]

//MARK: URLRequest friendsID
public func friendsGetRequests() -> [Friend] {
    guard let url = NetworkManager.getRequest(url: friendsUrl, settings: friendSettings) else { return [Friend]()}
    
    let (data, _, _) = URLSession.shared.syncRequest(with: url)
    do {
        let json = data!
        let friendResponse = try JSONDecoder().decode( GetFriendResponse.self, from: json)
        let items = friendResponse.response.items
        let realmFriends = mapItemsToRealmFriends(itemFriends: items)
            saveObjectToRealm(items: realmFriends, objRealm: RealmFriends.self, fieldID: \RealmFriends.id)
        return mapRealmsToFriends(realmFriends: realmFriends)
    } catch let error {
        print(error.localizedDescription)
        return [Friend]()
    }
}
//TODO: Change this metod universal
/// getAllRealmFriends
public func getAllRealmFriends() -> [RealmFriends] {
    do {
        let realm = try Realm()
        return realm.objects(RealmFriends.self).map{$0}
    } catch {
        print(error)
        return [RealmFriends]()
    }
}
/// mapRealmsToFriends
public func mapRealmsToFriends(realmFriends: [RealmFriends]) -> [Friend]{
    return realmFriends.map {  item in
        let friend = Friend(id: item.id)
        friend.firstName = item.firstName
        friend.surName = item.lastName
        friend.birthDayDate = item.birthDayDate
        friend.avatarPhoto = UIImage(data: item.data!) ?? UIImage()
        return friend
    }
}
//TODO: Change this metod universal
/// mapItemsToRealmFriends
public func mapItemsToRealmFriends(itemFriends: [FriendItem]) -> [RealmFriends]{
    return itemFriends.map {  item in
        let realmFriends = RealmFriends()
        
        let url = URL(string: item.photo100 ?? "")
        let image = try? Data(contentsOf: url!)
        realmFriends.data = image
        //        realmFriends.data = fromStringToData(stringURL: (item.photo100 ?? ""))
        
        realmFriends.url = item.photo100 ?? ""
        realmFriends.id = item.id
        realmFriends.firstName = item.firstName
        realmFriends.lastName = item.lastName
        realmFriends.birthDayDate = item.birthDay ?? ""
        return realmFriends
    }
}
