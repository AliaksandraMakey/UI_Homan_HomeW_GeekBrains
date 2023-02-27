

import UIKit
import RealmSwift
import Realm

func saveObjectToRealm<T>(items: [T], objRealm: AnyObject, fieldID: KeyPath<T, Int>) {
    do {
        let realm = try Realm()
        try? realm.write {
            items.forEach { item in
                let obj = realm.object(ofType: objRealm.self as! RealmSwiftObject.Type, forPrimaryKey: item[keyPath: fieldID])
                if obj == nil {
                    realm.add((item) as! Object)
                }
            }
        }
    } catch {
        print(error)
    }
}


// func saveGroups(items: [RealmGroups]) {
//    do {
//        let realm = try Realm()
//        try realm.write {
//            items.forEach { item in
//                let obj = realm.object(ofType: RealmGroups.self, forPrimaryKey: item.id)
//                if obj == nil {
//                    realm.add(item)
//                }
//            }
//        }
//    } catch {
//        print(error)
//    }
//}
