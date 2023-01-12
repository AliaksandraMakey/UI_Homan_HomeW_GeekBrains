

import Foundation


public struct NewsProfiles: Decodable {
    let id: Int
    var firstName: String?
//    let lastName: String?
    let photo100: String?
    
    enum NewProfilesKeys: String, CodingKey {
        case id
        case firstName = "first_name"
//        case lastName = "last_name"
        case photo100 = "photo_100"
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: NewProfilesKeys.self)
        id = try value.decode(Int.self, forKey: .id)
        photo100 = try value.decodeIfPresent(String.self, forKey: .photo100)
        firstName = try value.decodeIfPresent(String.self, forKey: .firstName)
//        lastName = try value.decodeIfPresent(String.self, forKey: .lastName)
    }
}
