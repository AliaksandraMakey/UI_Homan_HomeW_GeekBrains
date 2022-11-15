
import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userAvatar: UIView!
    @IBOutlet weak var userAvatarPhoto: UIView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var realmNotification: NotificationToken?
    
    var friendsArray = [Friend]()
    let gateway = FriendGateway()
    var savedFriendsArray = [Friend]()
    
    //MARK: arrayLetter
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
    
    //MARK: arrayByLetter
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
    //MARK: friendBySectionIndexAndRowIndex
    func friendBySectionIndexAndRowIndex(section: Int, row: Int) -> Friend {
        return arrayByLetter(sourceArray: friendsArray, letter: arrayLetter(sourceArray: friendsArray)[section])[row]
    }
    
    func fillFriendArray() {
        let friends = gateway.getFriends()
        friendsArray += friends
        friendsArray = friendsArray.sorted(by: { $0.surName < $1.surName })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillFriendArray()

        savedFriendsArray = friendsArray
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifierCustom")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        ///  тень и закругления для аватара
        userAvatarPhoto.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.shadowColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        userAvatar.layer.shadowOffset = CGSize(width: -3, height: -3)
        userAvatar.layer.shadowRadius = 10
        userAvatar.layer.shadowOpacity = 1
        userAvatarPhoto.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        
        ///  закругления для searchBar
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 16
        
        guard let realm = try? Realm() else { return }
        makeObserverFriends(realm: realm)
        tableView.reloadData()
    }
    
    private func makeObserverFriends(realm: Realm) {
        let objs = realm.objects(RealmFriends.self)
        realmNotification = objs.observe({ changes in
            switch changes {
            case let  .initial(obj):
                self.friendsArray = mapRealmsToFriends(realmFriends: Array(obj))
                self.tableView.reloadData()
            case .error(let error): print(error)
            case let  .update(realmFriends, deletions, insertions, modifications):
                DispatchQueue.main.async { [self] in
                    let realmArray = Array(realmFriends)
                    
                    self.friendsArray = mapRealmsToFriends(realmFriends: realmArray)
                    
                    tableView.reloadData()
                }
            }
        })
    }
    
    private func removeFriendFromArrayAndRealm(at indexPath: IndexPath ) {
        guard let realm = try? Realm() else { return }
        let letter = arrayLetter(sourceArray: friendsArray)[indexPath.section]
        let friend = arrayByLetter(sourceArray: friendsArray, letter: letter)[indexPath.row]
        
        try? realm.write{
            let obj = realm.object(ofType: RealmFriends.self, forPrimaryKey: friend.id)
            if obj != nil {
                realm.delete(obj!)
            }
        }
        if let index = friendsArray.firstIndex(where: {$0.id == friend.id}) {
            friendsArray.remove(at: index)
        }
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

//MARK: Extension FriendsViewController
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .none: break
        case .delete:
            removeFriendFromArrayAndRealm(at: indexPath)
            self.tableView.reloadData()
        case .insert: break
        @unknown default:
            print("Error FriendsViewController.editingStyle")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetter(sourceArray: friendsArray).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(sourceArray: friendsArray, letter: arrayLetter(sourceArray: friendsArray)[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifierCustom", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(friend: friendBySectionIndexAndRowIndex(section: indexPath.section, row: indexPath.row), completion: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // sender: friendsArray[indexPath.row] - при нажатии на экземпляр массива будет срабатывыать переход
        performSegue(withIdentifier: fromFriendsFrontGallery, sender: friendBySectionIndexAndRowIndex(section: indexPath.section, row: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let letter = arrayLetter(sourceArray: friendsArray)[section].uppercased()
        return letter == "" ? "Without surname" : letter
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { [self] (action, IndexPath) in
            removeFriendFromArrayAndRealm(at: indexPath)
            self.tableView.reloadData()
        })
        deleteAction.backgroundColor = #colorLiteral(red: 0.05872806162, green: 0.1163934693, blue: 0.08317165822, alpha: 1)
        return [deleteAction]
    }
}

//MARK: Extension UISearchBarDelegate
extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
