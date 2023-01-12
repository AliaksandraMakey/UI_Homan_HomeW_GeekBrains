
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

/// MARK: URLRequest groupsID
func groupsGetRequests(complition: @escaping ([Group]) -> Void) {
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
            saveGroups(items: realmGroups)
            let groups = mapRealmsToGroups(realmGroups: realmGroups)
            return Promise(value: groups)
        }.observe { result in
            complition(try! result.get())
        }
}

/// MARK: saveGroups
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

/// MARK: getGroups
public func getAllRealmGroups() -> [RealmGroups] {
    do {
        let realm = try Realm()
        return realm.objects(RealmGroups.self).map{$0}
    } catch {
        print(error)
        return [RealmGroups]()
    }
}

/// MARK: getGroups
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

/// MARK: mapGroupToRealmGroup
public func mapGroupToRealmGroup(group: Group) -> RealmGroups {
    let realmGroup = RealmGroups()
    realmGroup.name = group.titleGroup
    realmGroup.id = group.id
    return realmGroup
}

/// MARK: mapRealmsToGroups
public func mapRealmsToGroups(realmGroups: [RealmGroups]) -> [Group]{
    return realmGroups.map {  item in
        var group = Group()
        group.titleGroup = item.name
        group.id = item.id
        group.avatarPhoto = UIImage(data: item.data!) ?? UIImage()
        return group
    }
}

/// MARK: mapItemsToRealmGroups
public func mapItemsToRealmGroups(itemGroups: [GroupItem]) -> [RealmGroups]{
    return itemGroups.map {  item in
        let realmGroups = RealmGroups()
        let url = URL(string: item.photo50)
        let image = try? Data(contentsOf: url!)
        realmGroups.name = item.name
        realmGroups.url = item.photo50
        realmGroups.data = image
        realmGroups.id = item.id
        return realmGroups
    }
}


