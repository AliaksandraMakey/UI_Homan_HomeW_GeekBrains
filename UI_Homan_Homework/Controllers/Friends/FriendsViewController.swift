
import UIKit
import RealmSwift

//TODO: To do search bar
class FriendsViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userAvatarSubview: UIView!
    @IBOutlet weak var userAvatarPhoto: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var realmNotification: NotificationToken?
    
    var friendsArray = [Friend]()
    let gateway = FriendGateway()
    
    /// for searchBar
    var savedFriendsArray = [Friend]()
    /// for searchBa
    func fillFriendArray() {
        let friends = self.gateway.getFriends()
        self.friendsArray += friends
        self.friendsArray = self.friendsArray.sorted(by: { $0.surName < $1.surName })
    }
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillFriendArray()
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        /// for searchBar
        searchBar.delegate = self
        savedFriendsArray = friendsArray
        cornerSearchBar(searchBar: searchBar)
        
        cornerUIView(photo: userAvatarPhoto, photoSubview: userAvatarSubview)
        
        guard let realm = try? Realm() else { return }
        makeObserverFriends(realm: realm)
        tableView.reloadData()
    }
    //TODO: To do this function universal
    /// makeObserverFriends
    private func makeObserverFriends(realm: Realm) {
        let objs = realm.objects(RealmFriends.self)
        realmNotification = objs.observe({ changes in
            switch changes {
            case let  .initial(obj):
                self.friendsArray = mapRealmsToFriends(realmFriends: Array(obj))
                self.tableView.reloadData()
            case .error(let error): print(error)
            case let  .update(realmFriends, _, _, _):
                DispatchQueue.main.async { [self] in
                    let realmArray = Array(realmFriends)
                    
                    self.friendsArray = mapRealmsToFriends(realmFriends: realmArray)
                    
                    tableView.reloadData()
                }
            }
        })
    }
    /// prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsFrontGallery,
           let destinationVC = segue.destination as? GalleryViewController,
           let friend = sender as? Friend {
            destinationVC.friend = friend
        }
    }
}
//MARK: Extension FriendsViewController
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    /// friendBySectionIndexAndRowIndex
    func friendBySectionIndexAndRowIndex(section: Int, row: Int) -> Friend {
        let letter = arrayLetter(sourceArray: friendsArray, fieldName: \Friend.surName)[section]
        return arrayByLetter(sourceArray: friendsArray, letter: letter, fieldName: (\Friend.surName), fieldForSort: (\Friend.firstName))[row]
    }
    /// Editing Style
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let letter = arrayLetter(sourceArray: friendsArray, fieldName: \Friend.surName)[indexPath.section]
//        var arrayNew = arrayByLetter(sourceArray: friendsArray, letter: letter, fieldName: (\Friend.surName), fieldForSort: (\Friend.firstName))
//        forEditingStyle(tableView: tableView, editingStyle: editingStyle, at: indexPath, array: &arrayNew, fieldID: \Friend.id, objRealm: RealmFriends.self)
//    }
    /// numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetter(sourceArray: friendsArray, fieldName: (\Friend.surName)).count
    }
    /// numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = arrayLetter(sourceArray: friendsArray, fieldName: \Friend.surName)
        return arrayByLetter(sourceArray: friendsArray, letter: letter[section], fieldName: (\Friend.surName), fieldForSort: (\Friend.firstName)).count
    }
    /// cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(friend: friendBySectionIndexAndRowIndex(section: indexPath.section, row: indexPath.row))
        return cell
    }
    /// didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: fromFriendsFrontGallery, sender: friendBySectionIndexAndRowIndex(section: indexPath.section, row: indexPath.row))
    }
    /// titleForHeaderInSection
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let letter = arrayLetter(sourceArray: friendsArray, fieldName: \Friend.surName)[section].uppercased()
        return letter == "" ? "Without surname" : letter
    }
    /// heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    //TODO: Change this metod universal
    /// swipe actions delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let letter = arrayLetter(sourceArray: friendsArray, fieldName: \Friend.surName)[indexPath.section]
        var arrayNew = arrayByLetter(sourceArray: friendsArray, letter: letter, fieldName: (\Friend.surName), fieldForSort: (\Friend.firstName))
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [self] (action, sourceView, completionHandler) in
            removeObjectFromArrayAndRealm(at: indexPath, array: &arrayNew, fieldID: \Friend.id, objRealm: RealmFriends.self)
            self.tableView.reloadData()
        }
        let preventSwipeFullAction = UISwipeActionsConfiguration(actions: [deleteAction ])
        preventSwipeFullAction .performsFirstActionWithFullSwipe = false
        return preventSwipeFullAction
    }
}
//MARK: Extension UISearchBarDelegate
extension FriendsViewController: UISearchBarDelegate {
    //TODO: Change this metod universal
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
