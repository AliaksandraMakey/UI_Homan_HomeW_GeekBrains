

import Foundation

struct FriendResponse: Decodable {
    let count: Int
    let items: [FriendItem]
}
