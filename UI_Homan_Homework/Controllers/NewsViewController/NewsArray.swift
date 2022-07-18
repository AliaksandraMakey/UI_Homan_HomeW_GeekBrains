//
//  NewsArray.swift
//  UI_Homan_Homework
//
//  Created by aaa on 09.06.22.
//

import UIKit

//struct News {
//    var firstName = String()
//    var surName = String()
//    var avatarPhoto = UIImage()
//    var onePhoto = UIImage()
//    var twoPhoto = UIImage()
//}
extension NewsViewController {
    //и добавим функцию, чтобы заполнить массив
    func fillNewsArray() {
        //создаем друзей
        let newsOne = News(firstName: "Argus", surName: "Filch", avatarPhoto: UIImage(named: "Argus_Filch")!, onePhoto: UIImage(named: "1_1")!, twoPhoto: UIImage(named: "1_6")!)
//        let newsTwo = News(firstName: "Dobby", surName: "", avatarPhoto: UIImage(named: "Dobby")!, onePhoto: UIImage(named: "1_9")!, twoPhoto: UIImage(named: "1_5")!)
        let newsThree = News(firstName: "Ginevra", surName: "Weasley", avatarPhoto: UIImage(named: "Ginevra_Weasley")!, onePhoto: UIImage(named: "Hogwarts")!, twoPhoto: UIImage(named: "1_4")!)
        let newsFoure = News(firstName: "Alastor", surName: "Moody", avatarPhoto: UIImage(named: "Alastor_Moody")!, onePhoto: UIImage(named: "1_4")!, twoPhoto: UIImage(named: "1_4")!)
        let newsFive = News(firstName: "Hermione", surName: "Granger", avatarPhoto: UIImage(named: "Hermione_Granger")!, onePhoto: UIImage(named: "1_3")!, twoPhoto: UIImage(named: "Hogwarts")!)
        let newsSix = News(firstName: "Lord", surName: "Voldemort",  avatarPhoto: UIImage(named: "Lord_Voldemort")!, onePhoto: UIImage(named: "Hogwarts")!, twoPhoto: UIImage(named: "Hogwarts")!)
        let newsSeven = News(firstName: "Professor Albus", surName: "Dumbledore", avatarPhoto: UIImage(named: "Prof_Dumbledore")!, onePhoto: UIImage(named: "Hogwarts")!, twoPhoto: UIImage(named: "Hogwarts")!)
        let newsEight = News(firstName: "Professor Minerva", surName: "McGonagall", avatarPhoto: UIImage(named: "Prof_McGonagall")!, onePhoto: UIImage(named: "Hogwarts")!, twoPhoto: UIImage(named: "Hogwarts")!)
        let newsNine = News(firstName: "Professor Remus", surName: "Lupin", avatarPhoto: UIImage(named: "Remus_Lupin")!, onePhoto: UIImage(named: "Argus_Filch")!, twoPhoto: UIImage(named: "Argus_Filch")!)
        let newsTen = News(firstName: "Ron", surName: "Weasley", avatarPhoto: UIImage(named: "Ron_Weasley")!, onePhoto: UIImage(named: "Argus_Filch")!, twoPhoto: UIImage(named: "Argus_Filch")!)
//         добавляем их в массив
        newsArray.append(newsOne)
//        newsArray.append(newsTwo)
        newsArray.append(newsThree)
        newsArray.append(newsFoure)
        newsArray.append(newsFive)
        newsArray.append(newsSix)
        newsArray.append(newsSeven)
        newsArray.append(newsEight)
        newsArray.append(newsNine)
        newsArray.append(newsTen)
        newsArray = newsArray.sorted(by: { $0.surName < $1.surName })
    }
}
