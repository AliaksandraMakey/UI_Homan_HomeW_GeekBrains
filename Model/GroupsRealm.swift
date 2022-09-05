
import Foundation
import RealmSwift
import Realm

public class RealmGroups: Object {

    @Persisted(primaryKey: true)
    var id: Int

    @Persisted
    var name: String
    
    @Persisted
    var url: String
    
    @Persisted
    var data: Data?
}
