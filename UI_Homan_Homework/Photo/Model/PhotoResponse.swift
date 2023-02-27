
import Foundation

//MARK: PhotoResponse
struct PhotoResponse: Decodable {
    let count: Int
    let items: [PhotoItem]
}
