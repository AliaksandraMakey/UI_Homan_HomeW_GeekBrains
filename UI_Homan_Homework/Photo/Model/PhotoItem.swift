
import Foundation

struct PhotoItem: Decodable {
    let id: Int
    let date: Int
    let albumId: Int
    let ownerId: Int
    let sizes: [Size]
    
    enum PhotoItemKeys: String, CodingKey {
        case id
        case date
        case albumId = "album_id"
        case ownerId = "owner_id"
        case sizes
    }
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: PhotoItemKeys.self)
        id = try value.decode(Int.self, forKey: .id)
        date = try value.decode(Int.self, forKey: .date)
        albumId = try value.decode(Int.self, forKey: .albumId)
        ownerId = try value.decode(Int.self, forKey: .ownerId)
        sizes = try value.decode([Size].self, forKey: .sizes)
    }
}

struct Size: Decodable {
    let url: String
    let type: String
}
