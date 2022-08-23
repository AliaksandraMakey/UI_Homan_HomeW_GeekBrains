

import Foundation


struct GroupItem: Decodable {
    let id: Int
    let name: String
    let photoHundred: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photoHundred = "photo_100"

    }
}
