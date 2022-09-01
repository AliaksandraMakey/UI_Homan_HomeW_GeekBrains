

import Foundation


public struct GroupItem: Decodable {
    let id: Int
    let name: String
    let photo50: String
    
    enum GroupeItemKeys: String, CodingKey {
        case id
        case name
        case photo50 = "photo_50"
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: GroupeItemKeys.self)
        id = try value.decode(Int.self, forKey: .id)
        name = try value.decode(String.self, forKey: .name)
        photo50 = try value.decode(String.self, forKey: .photo50)
    }
}
