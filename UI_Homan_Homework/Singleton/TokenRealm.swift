
import Foundation
import RealmSwift

//MARK: TokenRealm
class TokenRealm: Object {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var token: String
    
    @Persisted
    var userId: Int
    
    @Persisted
    var createdAt: Date
    
    @Persisted
    var expiresInDate: Date
}
