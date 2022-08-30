//
//  RealmGroups.swift
//  UI_Homan_Homework
//
//  Created by aaa on 22.08.22.
//

import Foundation
import RealmSwift
import Realm

class RealmGroups: Object {

    @Persisted(primaryKey: true)
    var id: Int

    @Persisted
    var name: String

    @Persisted
    var photoHundred: String
}
