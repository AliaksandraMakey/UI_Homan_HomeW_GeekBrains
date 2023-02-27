

import Foundation


struct NewsGroups: Decodable {
    var id: Int
    var name: String?
    var avatarURL: String?
    
    enum NewsGroupsKeys: String, CodingKey {
        case id, name
        case avatarURL = "photo_100"
    }
    
    public  init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: NewsGroupsKeys.self)
        id = try value.decode(Int.self, forKey: .id)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        avatarURL = try value.decodeIfPresent(String.self, forKey: .avatarURL)
    }
}

