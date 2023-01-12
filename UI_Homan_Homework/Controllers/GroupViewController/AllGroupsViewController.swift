
import UIKit
import RealmSwift
import FirebaseFirestore


class AllGroupsViewController: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userAvatar: UIView!
    @IBOutlet weak var userAvatarPhoto: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var searchBarAllGroups: UISearchBar!
    
    private var realmNotification: NotificationToken?
    var allGroupeArray = [Group]()
    var selectedGroup: Group?
    
    
    func fillAllGroupeArray() {
        GroupGateway.getGroups() { groups in
            self.allGroupeArray = groups
            self.allGroupeArray = self.allGroupeArray.sorted(by: { $0.titleGroup < $1.titleGroup })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //    //MARK: viewDidAppear
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        tableView.reloadData()
    //    }
    
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillAllGroupeArray()
        savedAllGroupeArray = allGroupeArray
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifierCustom")
        tableView.delegate = self
        tableView.dataSource = self
        searchBarAllGroups.delegate = self
        
        userAvatarCustom(avatarPhoto: userAvatarPhoto, avatarSubview: userAvatar)
        avatarImage.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        ///  searchBar
        searchBarAllGroups.clipsToBounds = true
        searchBarAllGroups.layer.cornerRadius = 16
        
        guard let realm = try? Realm() else { return }
        makeObserverAllGroup(realm: realm)
    }
    private func makeObserverAllGroup(realm: Realm) {
        let objs = realm.objects(RealmGroups.self)
        realmNotification = objs.observe({ changes in
            switch changes {
            case let  .initial(obj):
                self.allGroupeArray = mapRealmsToGroups(realmGroups: Array(obj)).sorted(by: { $0.titleGroup < $1.titleGroup })
                self.tableView.reloadData()
            case .error(_):
                print("error makeObserverAllGroup")
            case let  .update(realmGroups, deletions, insertions, modifications):
                DispatchQueue.main.async { [self] in
                    let realmArray = Array(realmGroups)
                    
                    self.allGroupeArray = mapRealmsToGroups(realmGroups: realmArray)
                    
                    tableView.reloadData()
                }
            }
        })
    }
    
    private func removeGroupFromArrayAndRealm(at indexPath: IndexPath ) {
        guard let realm = try? Realm() else { return }
        let group =  allGroupeArray[indexPath.row]
        try? realm.write{
            let obj = realm.object(ofType: RealmGroups.self, forPrimaryKey: group.id)
            if obj != nil {
                realm.delete(obj!)
            }
        }
        if let index = allGroupeArray.firstIndex(where: {$0.id == group.id}) {
            allGroupeArray.remove(at: index)
        }
    }
    
    //MARK: searchBar
    var savedAllGroupeArray = [Group]()
    
    //MARK: arrayByLetter
    func arrayByLetter(sourceArray: [Group], letter: String) -> [Group] {
        var resultArray = [Group]()
        for item in sourceArray {
            let nameLatter = String(item.titleGroup.prefix(1)).lowercased()
            if nameLatter == letter.lowercased() {
                resultArray.append(item)
            }
        }
        return resultArray.sorted(by: { $0.titleGroup > $1.titleGroup })
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .none: break
        case .delete:
            removeGroupFromArrayAndRealm(at: indexPath)
            self.tableView.reloadData()
        case .insert: break
        @unknown default:
            print("Error AllGroupsViewController.editingStyle")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroupeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifierCustom", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(group: allGroupeArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGroup =  allGroupeArray[indexPath.row]
        self.selectedGroup = selectedGroup
        saveGroupToFirestore(id: selectedGroup.id)
        performSegue(withIdentifier: fromAllGroupsToGroup, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { [self] (action, IndexPath) in
            removeGroupFromArrayAndRealm(at: indexPath)
            self.tableView.reloadData()
        })
        deleteAction.backgroundColor = #colorLiteral(red: 0.05872806162, green: 0.1163934693, blue: 0.08317165822, alpha: 1)
        return [deleteAction]
    }
}

//MARK: Extension UISearchBarDelegate
extension AllGroupsViewController: UISearchBarDelegate {
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

