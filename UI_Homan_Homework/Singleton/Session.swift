
import UIKit

class Session {
    
    // создаем статическую константу с экземпляром класса
    static let instance = Session()
    //делаем конструктор приватным, что запретит создание экземпляра класса
    private init() {}
    
    var token: String?
    var userId: Int?
//     343939141

}
