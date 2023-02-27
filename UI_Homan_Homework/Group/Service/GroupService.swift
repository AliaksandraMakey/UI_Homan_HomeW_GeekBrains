
import Foundation
import WebKit
import RealmSwift
import Realm

let groupsUrl = "https://api.vk.com/method/groups.get"
var groupSettings = ["access_token": Session.instance.token,
                     "count": "10",
                     "fields": "name, photo_50",
                     "extended": "1",
                     "v": "5.131"]

//MARK: URLRequest groupsID
func groupsGetRequests(completion: @escaping ([Group]) -> Void) {
    guard let url = NetworkManager.getRequest(url: groupsUrl, settings: groupSettings) else { return }
    URLSession.shared.request(url: url)
        .map { data -> Future<GetGroupResponse> in
            let groupResponse = try? JSONDecoder().decode(GetGroupResponse.self, from: data)
            return Promise(value: groupResponse)
        }
        .map { groupResponse -> Future<[RealmGroups]> in
            let items = groupResponse.response.items
            let realmGroups = mapItemsToRealmGroups(itemGroups: (items as [GroupItem]))
            return Promise(value: realmGroups)
        }.map { realmGroups -> Future<[Group]> in
                saveObjectToRealm(items: realmGroups, objRealm: RealmGroups.self, fieldID: \RealmGroups.id)
            let groups = mapRealmsToGroups(realmGroups: realmGroups)
            return Promise(value: groups)
        }.observe { result in
            completion(try! result.get())
        }
}
//TODO: Change this metod universal
/// getAllRealmGroups
public func getAllRealmGroups() -> [RealmGroups] {
    do {
        let realm = try Realm()
        return realm.objects(RealmGroups.self).map{$0}
    } catch {
        print(error)
        return [RealmGroups]()
    }
}
/// getAllRealmGroupsByID
public func getAllRealmGroups(ids: [Int]) -> [RealmGroups] {
    do {
        let realm = try Realm()
        let groupsRealm = realm.objects(RealmGroups.self).filter("id IN %@", ids)
        return groupsRealm.map{$0}
    } catch {
        print(error)
        return [RealmGroups]()
    }
}
///mapRealmsToGroups
public func mapRealmsToGroups(realmGroups: [RealmGroups]) -> [Group]{
    return realmGroups.map {  item in
        let group = Group()
        group.titleGroup = item.name
        group.id = item.id
        group.avatarPhoto = UIImage(data: item.data!) ?? UIImage()
        return group
    }
}
//TODO: Change this metod universal
/// mapItemsToRealmGroups
public func mapItemsToRealmGroups(itemGroups: [GroupItem]) -> [RealmGroups]{
    return itemGroups.map {  item in
        let realmGroups = RealmGroups()
        
        //        realmGroups.data = fromStringToData(stringURL: item.photo50)
        let url = URL(string: item.photo50)
        let image = try? Data(contentsOf: url!)
        realmGroups.data = image
        
        realmGroups.url = item.photo50
        realmGroups.name = item.name
        realmGroups.id = item.id
        return realmGroups
    }
}

/////mapGroupToRealmGroup
//public func mapGroupToRealmGroup(group: Group) -> RealmGroups {
//    let realmGroup = RealmGroups()
//    realmGroup.name = group.titleGroup
//    realmGroup.id = group.id
//    return realmGroup
//}




////TODO: Change this metod universal
///// getAllRealmGroups
//public func getAllRealmGroups() -> [RealmGroups] {
//    do {
//        let realm = try Realm()
//        return realm.objects(RealmGroups.self).map{$0}
//    } catch {
//        print(error)
//        return [RealmGroups]()
//    }
//}
//
//
////TODO: Change this metod universal
///// getAllRealmFriends
//public func getAllRealmFriends() -> [RealmFriends] {
//    do {
//        let realm = try Realm()
//        return realm.objects(RealmFriends.self).map{$0}
//    } catch {
//        print(error)
//        return [RealmFriends]()
//    }
//}
