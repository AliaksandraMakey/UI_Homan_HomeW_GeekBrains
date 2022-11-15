
import UIKit




//----------------delete


extension NewsViewController {
    //и добавим функцию, чтобы заполнить массив
    func fillNewsArray() {
        //создаем друзей
   
        let newsThree = News(firstName: "Ginevra", surName: "Weasley", avatarPhoto: UIImage(named: "Ginevra_Weasley")!)
        let newsFoure = News(firstName: "Alastor", surName: "Moody", avatarPhoto: UIImage(named: "Alastor_Moody")!)
        let newsFive = News(firstName: "Hermione", surName: "Granger", avatarPhoto: UIImage(named: "Hermione_Granger")!)
        let newsSix = News(firstName: "Lord", surName: "Voldemort",  avatarPhoto: UIImage(named: "Lord_Voldemort")!)
        let newsSeven = News(firstName: "Professor Albus", surName: "Dumbledore", avatarPhoto: UIImage(named: "Prof_Dumbledore")!)
       
//         добавляем их в массив
        newsArray.append(newsThree)
        newsArray.append(newsFoure)
        newsArray.append(newsFive)
        newsArray.append(newsSix)
        newsArray.append(newsSeven)
     
        newsArray = newsArray.sorted(by: { $0.surName < $1.surName })
    }
}
