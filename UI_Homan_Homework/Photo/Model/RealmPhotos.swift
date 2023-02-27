
import Foundation
import RealmSwift
import Realm

//MARK: RealmPhotos
public class RealmPhotos: Object {

    @Persisted(primaryKey: true)
    var id: Int

    @Persisted
    var date: Int

    @Persisted
    var albumId: Int
    
    @Persisted
    var ownerId: Int
    
    @Persisted
    var url: String
    
    @Persisted
    var data: Data?
}
