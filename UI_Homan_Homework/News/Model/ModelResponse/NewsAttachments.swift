

import Foundation


struct Attachments: Decodable {
    let photo: Photo?
    let type: String
}

struct Photo: Decodable {
    let sizes: [Sizes]
}

struct Sizes: Decodable {
    let url: String?
}

