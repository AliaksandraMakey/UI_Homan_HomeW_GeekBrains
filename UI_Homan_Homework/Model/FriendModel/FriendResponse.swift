

import Foundation

struct FriendResponse: Decodable {
    let count: Int
    let items: [FriendItem]
    
    enum FriendResponseKeys: String, CodingKey {
        case count
        case items
    }
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: FriendResponseKeys.self)
        count = try value.decode(Int.self, forKey: .count)
        items = try value.decode([FriendItem].self, forKey: .items)
    }
}
