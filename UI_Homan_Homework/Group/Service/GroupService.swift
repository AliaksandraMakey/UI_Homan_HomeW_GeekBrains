
import Foundation
import WebKit
import RealmSwift
import Realm


let groupsUrl = "https://api.vk.com/method/groups.get"
var groupSettings = ["access_token": token,
                     "count": "10",
                     "fields": "name, photo_50",
                     "extended": "1",
                     "v": "5.131"]


/// MARK: URLRequest groupsID
func groupsGetRequests() -> [Group] {
    guard let url = NetworkManager.getRequest(url: groupsUrl, settings: groupSettings) else { return [Group]() }
    let (data, _, _) = URLSession.shared.syncRequest(with: url)
    guard let json = data ,
          let groupResponse = try? JSONDecoder().decode( GetGroupResponse.self, from: json) else { return [Group]() }
    let items = groupResponse.response.items
    let realmGroups = mapItemsToRealmGroups(itemGroups: items)
    saveGroups(items : realmGroups)
    return mapRealmsToGroups(realmGroups: realmGroups)
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

public func mapRealmsToGroups(realmGroups: [RealmGroups]) -> [Group]{
    return realmGroups.map {  item in
        
        var group = Group()
        
        group.titleGroup = item.name
        group.avatarPhoto = UIImage(data: item.data!) ?? UIImage()
        return group
    }
}

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


