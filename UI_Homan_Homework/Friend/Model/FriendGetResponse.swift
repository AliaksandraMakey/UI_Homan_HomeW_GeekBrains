
import Foundation


struct GetFriendResponse: Decodable {
    var response: FriendResponse
    
    enum GetFriendResponseKeys: String, CodingKey {
        case response
    }
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: GetFriendResponseKeys.self)
        response = try value.decode(FriendResponse.self, forKey: .response)
    }
}
