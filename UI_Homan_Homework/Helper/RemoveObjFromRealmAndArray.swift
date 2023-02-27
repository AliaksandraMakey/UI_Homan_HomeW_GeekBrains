
import UIKit
import RealmSwift
import Realm


/// removeFriendFromArrayAndRealm
func removeObjectFromArrayAndRealm<T: AnyObject>(at indexPath: IndexPath, array: inout [T], fieldID: KeyPath<T, Int>, objRealm: AnyObject) {
   guard let realm = try? Realm() else { return }
    
   let object = array[indexPath.row]
   try? realm.write{
       let obj = realm.object(ofType: objRealm.self as! RealmSwiftObject.Type, forPrimaryKey: object[keyPath: fieldID])
       if obj != nil {
           realm.delete(obj!)
       }
   }
   if let index = array.firstIndex(where: {$0[keyPath: fieldID] == object[keyPath: fieldID]}) {
       array.remove(at: index)
   }
}

//    /// removeFriendFromArrayAndRealm
//    private func removeFriendFromArrayAndRealm(at indexPath: IndexPath ) {
//        guard let realm = try? Realm() else { return }
////        let letter = arrayLetter(sourceArray: friendsArray, fieldName: \Friend.surName)[indexPath.section]
////        let arrayNew = arrayByLetter(sourceArray: friendsArray, letter: letter, fieldName: (\Friend.surName), fieldForSort: (\Friend.firstName))
//        let friend = friendsArray[indexPath.row]
//        try? realm.write{
//            let obj = realm.object(ofType: RealmFriends.self, forPrimaryKey: friend.id)
//            if obj != nil {
//                realm.delete(obj!)
//            }
//        }
//        if let index = friendsArray.firstIndex(where: {$0.id == friend.id}) {
//            friendsArray.remove(at: index)
//        }
//    }
