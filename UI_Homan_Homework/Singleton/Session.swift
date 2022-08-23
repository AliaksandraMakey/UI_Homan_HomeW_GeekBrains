
import UIKit

class Session {
    
    // создаем статическую константу с экземпляром класса
    static let instance = Session()
    //делаем конструктор приватным, что запретит создание экземпляра класса
    private init() {}
    
    var token: String?
//"vk1.a.SqPrlZyy0u6lXyOlxOtqIQQd5oGjSMID67NQhHq_MFcKNHkF-6m7RIgmL72VYwzK8qSuc55DUdIZnV87wWRQj7tqylO3XW8iEGLw2qIwgF1HiXjDfiHmeVMaKWjild8GFsY5Jektzr_rOOwqsb-ND6JAIPeaFJSbJW_bGwsL8FT1pchrYWYwL-_gl2ZQwTGq"
    var userId: Int?
//     343939141

}
