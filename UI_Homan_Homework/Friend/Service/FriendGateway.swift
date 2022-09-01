
import Foundation

class FriendGateway {
    
    public func getFriends() -> [Friend] {
        let realmFriends = getAllRealmFriends()
        if !realmFriends.isEmpty {
            return mapRealmsToFriends(realmFriends: realmFriends)
        } else {
            return friendsGetRequests()
        }
    }
}
