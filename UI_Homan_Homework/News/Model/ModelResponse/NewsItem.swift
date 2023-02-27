

import Foundation

 struct NewsItem: Decodable {
    let sourceID, postID: Int
    let ownerID: Int
    let text: String?
    let date: Double
    let attachments: [Attachments]?

     var photosURL: [String]? {
         get {
             let photosURL = attachments?.compactMap{ $0.photo?.sizes?.last?.url }
             return photosURL
         }
     }
     
     
     
    enum NewsItemKeys: String, CodingKey {
        case sourceID =  "source_id"
        case ownerID = "owner_id"
        case postID = "post_id"
        case text, date, attachments
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: NewsItemKeys.self)
        sourceID = try value.decode(Int.self, forKey: .sourceID)
        postID = try value.decode(Int.self, forKey: .postID)
        text = try value.decode(String.self, forKey: .text)
        date = try value.decode(Double.self, forKey: .date)
        attachments = try value.decode([Attachments].self, forKey: .attachments)
        ownerID = try value.decode(Int.self, forKey: .ownerID)
    }
}
