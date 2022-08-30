//
//  Realm.swift
//  UI_Homan_Homework
//
//  Created by aaa on 22.08.22.
//

import Foundation
import RealmSwift
import Realm

public class RealmFriends: Object {

    @Persisted(primaryKey: true)
    var id: Int

    @Persisted
    var firstName: String

    @Persisted
    var lastName: String
    
    @Persisted
    var birthDayDate: String
    
    @Persisted
    var url: String
    
    @Persisted
    var data: Data?
}
