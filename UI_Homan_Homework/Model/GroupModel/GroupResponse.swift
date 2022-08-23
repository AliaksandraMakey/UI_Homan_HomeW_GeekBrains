

import Foundation

struct GroupResponse: Decodable {
    let count: Int
    let items: [GroupItem]
}
