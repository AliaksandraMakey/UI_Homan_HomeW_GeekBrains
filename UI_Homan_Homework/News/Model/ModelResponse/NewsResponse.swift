
import Foundation

struct NewsResponse: Decodable {
    let profiles: [NewsProfiles]?
    let groups: [NewsGroups]?
    let items: [NewsItem]?
    let nextFrom: String
    
    enum NewsResponseKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}
