
import Foundation

class GroupGateway {
    
    public static func getGroups() -> [Group] {
        let realmGroups = getAllRealmGroups()
        if !realmGroups.isEmpty {
            return mapRealmsToGroups(realmGroups: realmGroups)
        } else {
            return groupsGetRequests()
        }
    }
}
