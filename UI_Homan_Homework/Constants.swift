
import UIKit


var cellHeight = 80

let space = " "

// сердце закрашено / не закрашено
var likeEnable = false
// переменная используется в подсчете лайков
var counter = 0

let reuseIdentifierCustom = "reuseIdentifierCustom"
let reuseIdentifierGalleryCollectionCell = "reuseIdentifierGalleryCollectionCell "

// создадим индетикатор для segue от AllGroups к Group (как и в AllGroupsContr)
let fromAllGroupsToGroup = "fromAllGroupsToGroup"

//  соединяем связь в  sergue fromFriendsFronGallery
let fromFriendsFrontGallery = "fromFriendsFrontGallery"
let fromHomeVCToWebVC = "FromHomeVCToWebVC"
let fromWebVCToNewsVC = "FromWebVCToNewsVC"
let scale = CGFloat(30)
