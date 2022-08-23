//
//  RealmPhotos.swift
//  UI_Homan_Homework
//
//  Created by aaa on 22.08.22.
//

import Foundation
import RealmSwift
import Realm

class RealmPhotos: Object {

    @Persisted(primaryKey: true)
    var id: Int

    @Persisted
    var date: Int

    @Persisted
    var albumId: Int
    
    @Persisted
    var ownerId: Int
}
