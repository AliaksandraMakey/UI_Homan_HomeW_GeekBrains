

import Foundation


struct NewsGroups: Decodable {
    var id: Int
    var name: String
    var photo100: String?
    
    enum NewsGroupsKeys: String, CodingKey {
        case id
        case name
        case photo100 = "photo_100"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: NewsGroupsKeys.self)
        id = try value.decode(Int.self, forKey: .id)
        name = try value.decode(String.self, forKey: .name)
        photo100 = try value.decodeIfPresent(String.self, forKey: .photo100)
    }
}

