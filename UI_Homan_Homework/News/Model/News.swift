
import UIKit

public struct NewsPost {

    var idPost = Int() // post from NewsItem
    var idPersonOrGroup = Int() // id from Profiles or Group
    var namePersonOrGroupId: String? // grouts or person
    
    var postType = String() // from NewsItem
    var textPost = String() // from NewsItem
    
    var photoPost = [UIImage]() // just photo
    var photoTitlePersonOrGroup = UIImage() // photo100 grouts or person
}


