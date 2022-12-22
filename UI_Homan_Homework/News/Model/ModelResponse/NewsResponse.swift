
import Foundation

struct NewsResponse: Decodable {
    let profiles: [NewsProfiles]?
    let groups: [NewsGroups]?
    let items: [NewsItem]?
}
