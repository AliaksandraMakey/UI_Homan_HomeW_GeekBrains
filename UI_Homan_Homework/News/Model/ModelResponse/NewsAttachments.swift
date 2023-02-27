

import Foundation


struct Attachments: Decodable {
    
    //  фото постов
    let photo: Photo?
    let type: String? // "photo"    "video"
}

struct Photo: Decodable {
    let id, ownerID: Int?
    let sizes: [Sizes]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
    }
}

struct Sizes: Decodable {
    let url: String?
    let type: String? //  "r" "q"
}


