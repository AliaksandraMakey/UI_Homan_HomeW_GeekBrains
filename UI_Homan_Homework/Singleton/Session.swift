//
//  Session.swift
//  UI_Homan_Homework
//
//  Created by aaa on 30.06.22.
//

import UIKit

class Session {
    
    // создаем статическую константу с экземпляром класса
    static let instance = Session()
    //делаем конструктор приватным, что запретит создание экземпляра класса
    private init() {}
    
    var token: String?
    var userId: Int?

}
