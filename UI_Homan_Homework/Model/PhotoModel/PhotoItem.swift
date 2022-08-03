
import Foundation

struct PhotoItem: Decodable {
    let id: Int
    let date: Int
    let albumId: Int
    let ownerId: Int

    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case albumId = "album_id"
        case ownerId = "owner_id"
    }
}
