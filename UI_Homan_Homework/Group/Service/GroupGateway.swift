
import Foundation
import RealmSwift
class GroupGateway {
    
    public static func getGroups(completion: @escaping ([Group]) -> Void) {
        DispatchQueue.global().async {
            let realmGroups = getAllRealmGroups()
            if !realmGroups.isEmpty {
                completion(mapRealmsToGroups(realmGroups: realmGroups))
            } else {
                groupsGetRequests() { result in
                    completion(result)
                }
            }
        }
    }
    
    // обработать дублирование кода
    public static func getGroups(ids: [Int], completion: @escaping ([Group]) -> Void) {
        DispatchQueue.global().async {
            let realmGroups = getAllRealmGroups(ids: ids)
            if !realmGroups.isEmpty {
                completion(mapRealmsToGroups(realmGroups: realmGroups))
            } else {
                groupsGetRequests() { result in
                    completion(result)
                }
            }
        }
    }
}
