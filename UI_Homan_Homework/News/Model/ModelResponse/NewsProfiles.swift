

import Foundation


struct NewsProfiles: Decodable {
    let id: Int
    let photo100: String?
    
    enum NewProfilesKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: NewProfilesKeys.self)
        id = try value.decode(Int.self, forKey: .id)
        photo100 = try value.decodeIfPresent(String.self, forKey: .photo100)
    }
}
