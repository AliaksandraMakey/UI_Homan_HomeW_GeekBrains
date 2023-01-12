
import Foundation
import RealmSwift
class GroupGateway {
    
    public static func getGroups(complition: @escaping ([Group]) -> Void) {
        DispatchQueue.global().async {
            let realmGroups = getAllRealmGroups()
            if !realmGroups.isEmpty {
                complition(mapRealmsToGroups(realmGroups: realmGroups))
            } else {
                groupsGetRequests() { result in
                    complition(result)
                }
            }
        }
    }
    
    public static func getGroups(ids: [Int], complition: @escaping ([Group]) -> Void) {
        DispatchQueue.global().async {
            let realmGroups = getAllRealmGroups(ids: ids)
            if !realmGroups.isEmpty {
                complition(mapRealmsToGroups(realmGroups: realmGroups))
            } else {
                groupsGetRequests() { result in
                    complition(result)
                }
            }
        }
    }
}
