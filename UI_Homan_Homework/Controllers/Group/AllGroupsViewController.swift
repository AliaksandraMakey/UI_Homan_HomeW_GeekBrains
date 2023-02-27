
import UIKit
import RealmSwift
import FirebaseFirestore
import Realm

//TODO: To do search bar
class AllGroupsViewController: UIViewController {
    let db = Firestore.firestore()
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userAvatarSubview: UIView!
    @IBOutlet weak var userAvatarPhoto: UIImageView!
    @IBOutlet weak var searchBarAllGroups: UISearchBar!
    
    private var realmNotification: NotificationToken?
    var allGroupeArray = [Group]()
    var selectedGroup: Group?
    
    /// for searchBar
    var savedAllGroupeArray = [Group]()
    
    func fillAllGroupeArray() {
        GroupGateway.getGroups() { groups in
            self.allGroupeArray = groups
            self.allGroupeArray = self.allGroupeArray.sorted(by: { $0.titleGroup < $1.titleGroup })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillAllGroupeArray()
        
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        /// for searchBar
        savedAllGroupeArray = allGroupeArray
        searchBarAllGroups.delegate = self
        cornerSearchBar(searchBar: searchBarAllGroups)
        
        cornerUIView(photo: userAvatarPhoto, photoSubview: userAvatarSubview)
        
        guard let realm = try? Realm() else { return }
        makeObserverAllGroup(realm: realm)
    }
    //FIXME: To do this function universal
    private func makeObserverAllGroup(realm: Realm) {
        let objs = realm.objects(RealmGroups.self)
        realmNotification = objs.observe({ changes in
            switch changes {
            case let  .initial(obj):
                self.allGroupeArray = mapRealmsToGroups(realmGroups: Array(obj)).sorted(by: { $0.titleGroup < $1.titleGroup })
                self.tableView.reloadData()
            case .error(let error): print(error)
                // case let  .update(realmGroups, deletions, insertions, modifications):
            case let  .update(realmGroups, _, _, _):
                DispatchQueue.main.async { [self] in
                    let realmArray = Array(realmGroups)
                    
                    self.allGroupeArray = mapRealmsToGroups(realmGroups: realmArray)
                    
                    tableView.reloadData()
                }
            }
        })
    }
    //MARK: saveGroupToFirestore
    func saveGroupToFirestore(id: Int) {
        getGroupIdFirestore { groupIds in
            if  !groupIds.contains(id) {
                var newGroupFirestore = [Int]()
                newGroupFirestore.append(id)
                newGroupFirestore += groupIds
                self.db
                    .collection("userGroups")
                    .document(String(Session.instance.userId!))
                    .setData(["groupIds" : newGroupFirestore])
            }
        }
    }
}
//MARK: Extension AllGroupsViewController
extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    /// editingStyle
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        //FIXME: To do this code universal
//        forEditingStyle(tableView: tableView, editingStyle: editingStyle, at: indexPath, array: &allGroupeArray, fieldID: \Group.id, objRealm: RealmGroups.self)
//    }
    /// numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroupeArray.count
    }
    /// cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(group: allGroupeArray[indexPath.row])
        return cell
    }
    /// heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    /// didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGroup =  allGroupeArray[indexPath.row]
        self.selectedGroup = selectedGroup
        saveGroupToFirestore(id: selectedGroup.id)
        performSegue(withIdentifier: fromAllGroupsToGroup, sender: nil)
    }
    /// swipe actions delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [self] (action, sourceView, completionHandler) in
            removeObjectFromArrayAndRealm(at: indexPath, array: &allGroupeArray, fieldID: \Group.id, objRealm: RealmGroups.self)
            self.tableView.reloadData()
        }
        let preventSwipeFullAction = UISwipeActionsConfiguration(actions: [deleteAction ])
        preventSwipeFullAction .performsFirstActionWithFullSwipe = false
        return preventSwipeFullAction
    }
}
//MARK: Extension UISearchBarDelegate
extension AllGroupsViewController: UISearchBarDelegate {
    //TODO: Change this metod universal
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.allGroupeArray = self.savedAllGroupeArray
        } else {
            self.allGroupeArray = self.savedAllGroupeArray.filter ({
                $0.titleGroup.lowercased().contains(searchText.lowercased())
            })
        }
        self.tableView.reloadData()
    }
}


//
//func makeTestObserverAllGroup<T>(realm: Realm, tableView: UITableView, array: inout [T], mapRealmToObject: (_ realm: [T]) -> [T]) {
//    var realmNotification: NotificationToken?
//    let objs = realm.objects(RealmGroups.self)
//    realmNotification = objs.observe({ changes in
//        switch changes {
//        case let  .initial(obj):
//            array = mapRealmToObject(obj)
//            tableView.reloadData()
//        case .error(let error): print(error)
//            // case let  .update(realmGroups, deletions, insertions, modifications):
//        case let  .update(realmGroups, _, _, _):
//            DispatchQueue.main.async { _ in
//                let realmArray = Array(realmGroups)
//
//                array = mapRealmsToGroups(realmGroups: realmArray)
//
//                tableView.reloadData()
//            }
//        }
//    })
//}

//private func makeObserverAllGroup(realm: Realm) {
//    let objs = realm.objects(RealmGroups.self)
//    realmNotification = objs.observe({ changes in
//        switch changes {
//        case let  .initial(obj):
//            self.allGroupeArray = mapRealmsToGroups(realmGroups: Array(obj)).sorted(by: { $0.titleGroup < $1.titleGroup })
//            self.tableView.reloadData()
//        case .error(let error): print(error)
//            // case let  .update(realmGroups, deletions, insertions, modifications):
//        case let  .update(realmGroups, _, _, _):
//            DispatchQueue.main.async { [self] in
//                let realmArray = Array(realmGroups)
//
//                self.allGroupeArray = mapRealmsToGroups(realmGroups: realmArray)
//
//                tableView.reloadData()
//            }
//        }
//    })
//}
// func makeObserverFriends(realm: Realm) {
//    let objs = realm.objects(RealmFriends.self)
//    realmNotification = objs.observe({ changes in
//        switch changes {
//        case let  .initial(obj):
//            self.friendsArray = mapRealmsToFriends(realmFriends: Array(obj))
//            self.tableView.reloadData()
//        case .error(let error): print(error)
//        case let  .update(realmFriends, _, _, _):
//            DispatchQueue.main.async { [self] in
//                let realmArray = Array(realmFriends)
//
//                self.friendsArray = mapRealmsToFriends(realmFriends: realmArray)
//
//                tableView.reloadData()
//            }
//        }
//    })
//}
