
import Foundation

//MARK: FriendGateway
class FriendGateway {
    /// getFriends
    public func getFriends() -> [Friend] {
        let realmFriends = getAllRealmFriends()
        if !realmFriends.isEmpty {
            return mapRealmsToFriends(realmFriends: realmFriends)
        } else {
            return friendsGetRequests()
        }
    }
}
