//
//  FriendsViewController.swift
//  UI_Homan_Homework
//
//  Created by aaa on 25.05.22.
//

import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userAvatar: UIView!
    @IBOutlet weak var userAvatarPhoto: UIView!
    
    //  прокидываем Outlet для searchBar
    @IBOutlet weak var searchBar: UISearchBar!
    
    //добавим массив для Friends, чтобы воспользоваться в расширении
    var friendsArray = [Friend]()
    let gateway = FriendGateway()
    
    //MARK: searchBar
    var savedFriendsArray = [Friend]()
    
    func arrayLetter(sourceArray: [Friend]) -> [String] {
        var resultArray = [String]()
        for item in sourceArray {
            let nameLatter = String(item.surName.prefix(1))
            if !resultArray.contains(nameLatter.lowercased()) {
                resultArray.append(nameLatter.lowercased())
            }
        }
        return resultArray
    }
    
    func arrayByLetter(sourceArray: [Friend], letter: String) -> [Friend] {
        var resultArray = [Friend]()
        for item in sourceArray {
            let nameLatter = String(item.surName.prefix(1)).lowercased()
            if nameLatter == letter.lowercased() {
                resultArray.append(item)
            }
        }
        return resultArray.sorted(by: { $0.firstName < $1.firstName })
    }
    
    // находит обьект Friend по индексу секции и индексу ряда
    func friendBySectionIndexAndRowIndex(section: Int, row: Int) -> Friend {
        return arrayByLetter(sourceArray: friendsArray, letter: arrayLetter(sourceArray: friendsArray)[section])[row]
    }
    
    func fillFriendArray() {
       
        var friends = gateway.getFriends()
   
        friendsArray += friends
        friendsArray = friendsArray.sorted(by: { $0.surName < $1.surName })
    }
    
    //MARK: func viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // вызовем функцию, обьявленную для массива
        fillFriendArray()
        // инициализируем sevedFriendsArray и передаем  ему знание массива friendsArray
        savedFriendsArray = friendsArray
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
        ///  тень и закругления для аватарки
        userAvatarPhoto.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.shadowColor =  #colorLiteral(red: 0.3123562634, green: 0.663256526, blue: 0.474018991, alpha: 0.8709902732)
        userAvatar.layer.shadowOffset = CGSize(width: -3, height: -3)
        userAvatar.layer.shadowRadius = 10
        userAvatar.layer.shadowOpacity = 1
        userAvatarPhoto.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        ///  закругления для searchBar
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 16
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsFrontGallery,
           //           let  sourceVC = segue.source as? FriendsViewController,
           let destinationVC = segue.destination as? GalleryViewController,
           let friend = sender as? Friend {
            destinationVC.friend = friend
        }
    }
}

//MARK: Extension 
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // для того, чтобы разбить по секциям нам нужно обозначить метод для Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetter(sourceArray: friendsArray).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // возвращаем массив, выведенный построчно ( .count )
        return arrayByLetter(sourceArray: friendsArray, letter: arrayLetter(sourceArray: friendsArray)[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
    
        cell.configure(friend: friendBySectionIndexAndRowIndex(section: indexPath.section, row: indexPath.row), completion: nil)
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // sender: friendsArray[indexPath.row] - при нажатии на экземпляр массива будет срабатывыать переход
        performSegue(withIdentifier: fromFriendsFrontGallery, sender: friendBySectionIndexAndRowIndex(section: indexPath.section, row: indexPath.row))
    }
    
    // добавим функцию, которая будет сортировать по начальной букве title. для каждой секции отдельно будет title и номер секции section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let letter = arrayLetter(sourceArray: friendsArray)[section].uppercased()
        return letter == "" ? "Without surname" : letter
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
}

//MARK: Extension UISearchBarDelegate
extension FriendsViewController: UISearchBarDelegate {
    // воспользуемся методом, который посредсвом searchText будет фильтровать массив
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //НО! если мы профильтруем friendsArray, элементы массива вернутся уже отфильтрованными. Для того, чтобы сохранить прежний количество элементов создадим массив sevedFriendsArray и передадим ему знаечние friendsArray
        if searchText.isEmpty {
            self.friendsArray = self.savedFriendsArray
        } else {
            self.friendsArray = self.savedFriendsArray.filter ({
                $0.firstName.lowercased().contains(searchText.lowercased()) || $0.surName.lowercased().contains(searchText.lowercased())
            })
        }
        self.tableView.reloadData()
    }
    
}

