
import Foundation



struct FriendItem: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    
    enum FriendItemKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: FriendItemKeys.self)
        id = try value.decode(Int.self, forKey: .id)
        firstName = try value.decode(String.self, forKey: .firstName)
        lastName = try value.decode(String.self, forKey: .lastName)

    }
    
}
