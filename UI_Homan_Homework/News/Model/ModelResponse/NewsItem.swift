

import Foundation

public struct NewsItem: Decodable {
    let sourceId: Int
    let postType: String?
    let text: String?
    let attachments: [Attachments]?
    
    enum NewsItemKeys: String, CodingKey {
        case sourceId =  "source_id"
        case postType = "post_type"
        case text, attachments
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: NewsItemKeys.self)
        sourceId = try value.decode(Int.self, forKey: .sourceId)
        postType = try value.decode(String.self, forKey: .postType)
        text = try value.decode(String.self, forKey: .text)
        attachments = try value.decode([Attachments].self, forKey: .attachments)
    }
}
