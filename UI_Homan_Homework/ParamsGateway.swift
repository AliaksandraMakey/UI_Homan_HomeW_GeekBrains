
import Foundation
import RealmSwift

public class RealmParams: Object {

    @Persisted(primaryKey: true)
    var token: String?
    
    @Persisted
    var userId: Int?
}


//struct GetParamsResponse: Decodable {
//    var access_token: String
//    var user_id: String
//
//    enum GetParamsResponseKeys: String, CodingKey {
//        case access_token
//        case user_id
//    }
//    init(from decoder: Decoder) throws {
//        let value = try decoder.container(keyedBy: GetParamsResponseKeys.self)
//        access_token = try value.decode(String.self, forKey: .access_token)
//        user_id = try value.decode(String.self, forKey: .user_id)
//
//    }
//}
