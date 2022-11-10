
import Foundation
import RealmSwift
class GroupGateway {
    
    public static func getGroups() -> [Group] {
        let realmGroups = getAllRealmGroups()
        if !realmGroups.isEmpty {
            return mapRealmsToGroups(realmGroups: realmGroups)
        } else {
            return groupsGetRequests()
        }
    }
    
    public static func getGroups(ids: [Int]) -> [Group] {
        let realmGroups = getAllRealmGroups(ids: ids)
        if !realmGroups.isEmpty {
            return mapRealmsToGroups(realmGroups: realmGroups)
        } else {
            return groupsGetRequests()
        }
    }
}
