
import Foundation



public struct FriendItem: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let birthDayDate: String
    let photo100: String
    
    
    enum FriendItemKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case birthDayDate = "bdate"
        case photo100 = "photo_100"
        
    }
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: FriendItemKeys.self)
        id = try value.decode(Int.self, forKey: .id)
        firstName = try value.decode(String.self, forKey: .firstName)
        lastName = try value.decode(String.self, forKey: .lastName)
        birthDayDate = try value.decode(String.self, forKey: .birthDayDate)
        photo100 = try value.decode(String.self, forKey: .photo100)
    }
    
}
