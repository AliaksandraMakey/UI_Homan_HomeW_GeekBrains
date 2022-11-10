//
//  TokenRealm.swift
//  UI_Homan_Homework
//
//  Created by aaa on 02.09.22.
//

import Foundation
import RealmSwift

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
