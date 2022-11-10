
import UIKit


extension NewsViewController {
    //и добавим функцию, чтобы заполнить массив
    func fillNewsArray() {
        //создаем друзей
   
        let newsThree = News(firstName: "Ginevra", surName: "Weasley", avatarPhoto: UIImage(named: "Ginevra_Weasley")!)
        let newsFoure = News(firstName: "Alastor", surName: "Moody", avatarPhoto: UIImage(named: "Alastor_Moody")!)
        let newsFive = News(firstName: "Hermione", surName: "Granger", avatarPhoto: UIImage(named: "Hermione_Granger")!)
        let newsSix = News(firstName: "Lord", surName: "Voldemort",  avatarPhoto: UIImage(named: "Lord_Voldemort")!)
        let newsSeven = News(firstName: "Professor Albus", surName: "Dumbledore", avatarPhoto: UIImage(named: "Prof_Dumbledore")!)
        let newsEight = News(firstName: "Professor Minerva", surName: "McGonagall", avatarPhoto: UIImage(named: "Prof_McGonagall")!)
        let newsNine = News(firstName: "Professor Remus", surName: "Lupin", avatarPhoto: UIImage(named: "Remus_Lupin")!)
        let newsTen = News(firstName: "Ron", surName: "Weasley", avatarPhoto: UIImage(named: "Ron_Weasley")!)
//         добавляем их в массив
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
