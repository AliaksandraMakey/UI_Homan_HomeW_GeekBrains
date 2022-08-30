
import Foundation

struct PhotoResponse: Decodable {
    let count: Int
    let items: [PhotoItem]
}
