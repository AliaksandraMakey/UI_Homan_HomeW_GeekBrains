//
//  FriendsArray.swift
//  UI_Homan_Homework
//
//  Created by aaa on 04.06.22.
//

import UIKit

extension FriendsViewController {
    //и добавим функцию, чтобы заполнить массив
    func fillFriendArray() {
        
        //создаем друзей
        let friendOne = Friend(firstName: "Argus", surName: "Filch", visitDate: "Last visit 9 March",
                               avatarPhoto: UIImage(named: "Argus_Filch")!,
                               photoAlbum: [UIImage(named: "Argus_Filch")!,
                                            UIImage(named: "Education")!])
        
        let friendTwo = Friend(firstName: "Dobby", surName: "", visitDate: "Last visit yesterday",
                               avatarPhoto: UIImage(named: "Dobby")!,
                               photoAlbum: [UIImage(named: "Dobby")!])
        
        let friendThree = Friend(firstName: "Ginevra", surName: "Weasley", visitDate: "Last visit 30 May",
                                 avatarPhoto: UIImage(named: "Ginevra_Weasley")!,
                                 photoAlbum: [UIImage(named: "Ginevra_Weasley")!,
                                              UIImage(named: "1_2")!,
                                              UIImage(named: "1_3")!,
                                              UIImage(named: "1_5")!])
        
        let friendFoure = Friend(firstName: "Alastor", surName: "Moody", visitDate: "Last visit 30 May",
                                 avatarPhoto: UIImage(named: "Alastor_Moody")!,
                                 photoAlbum: [UIImage(named: "Alastor_Moody")!])
        let friendFive = Friend(firstName: "Hermione", surName: "Granger", visitDate: "Last visit 31 May",
                                avatarPhoto: UIImage(named: "Hermione_Granger")!,
                                photoAlbum: [UIImage(named: "Hermione_Granger")!,
                                             UIImage(named: "Hermione_Kat")!,
                                             UIImage(named: "Hermione_Hi")!])
        
        let friendSix = Friend(firstName: "Lord", surName: "Voldemort", visitDate: "Last visit today",
                               avatarPhoto: UIImage(named: "Lord_Voldemort")!,
                               photoAlbum: [UIImage(named: "Lord_Voldemort")!])
                                
        let friendSeven = Friend(firstName: "Professor Albus", surName: "Dumbledore", visitDate: "Last visit 1 June",
                                 avatarPhoto: UIImage(named: "Prof_Dumbledore")!,
                                 photoAlbum: [UIImage(named: "Prof_Dumbledore")!,
                                              UIImage(named: "Hogwarts-1")!,
                                              UIImage(named: "owl")!,
                                              UIImage(named: "Education")!])
                                
        let friendEight = Friend(firstName: "Professor Minerva", surName: "McGonagall", visitDate: "Last visit 2 June",
                                 avatarPhoto: UIImage(named: "Prof_McGonagall")!,
                                 photoAlbum: [UIImage(named: "Prof_McGonagall")!,
                                              UIImage(named: "Magic_Sticks")!])
        
        let friendNine = Friend(firstName: "Professor Remus", surName: "Lupin", visitDate: "Last visit yesterday",
                                avatarPhoto: UIImage(named: "Remus_Lupin")!,
                                photoAlbum: [UIImage(named: "Remus_Lupin")!])
        let friendTen = Friend(firstName: "Ron", surName: "Weasley", visitDate: "Last visit today",
                               avatarPhoto: UIImage(named: "Ron_Weasley")!,
                               photoAlbum: [UIImage(named: "Ron_Weasley")!,
                                            UIImage(named: "Ron_Heart")!,
                                            UIImage(named: "Evil_book")!])
        
        // добавляем их в массив
        friendsArray.append(friendOne)
        friendsArray.append(friendTwo)
        friendsArray.append(friendThree)
        friendsArray.append(friendFoure)
        friendsArray.append(friendFive)
        friendsArray.append(friendSix)
        friendsArray.append(friendSeven)
        friendsArray.append(friendEight)
        friendsArray.append(friendNine)
        friendsArray.append(friendTen)
        friendsArray = friendsArray.sorted(by: { $0.surName < $1.surName })
    }
}
