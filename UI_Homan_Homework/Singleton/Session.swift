
import UIKit

//MARK: user
class Session {
    
    static let instance = Session()
    private init() {}
    
    var token: String?
    var userId: Int?
    var expiresInDate: Date?
}

