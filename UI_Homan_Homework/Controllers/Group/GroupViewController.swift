
import UIKit
import RealmSwift
import FirebaseFirestore

//TODO: To do search bar
//TODO: Delete action
class GroupViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userAvatarSubview: UIView!
    @IBOutlet weak var userAvatarPhoto: UIImageView!
    @IBOutlet weak var searchBarMyGroups: UISearchBar!
    
    private var realmNotification: NotificationToken?
    
    var groupArray = [Group]()
    /// for searchBar
    var savedGroupeArray = [Group]()
    /// fillGroupArray
    func fillGroupArray() {
        getGroupIdFirestore { groupIds in
            GroupGateway.getGroups(ids: groupIds, completion: { groups in
                self.groupArray += groups
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fillGroupArray()
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        /// for searchBar
        searchBarMyGroups.delegate = self
        savedGroupeArray = groupArray
        cornerSearchBar(searchBar: searchBarMyGroups)
        
        cornerUIView(photo: userAvatarPhoto, photoSubview: userAvatarSubview)
    }
    /// isItemAlreadyArray
    func isItemAlreadyArray(group: Group) -> Bool {
        return groupArray.contains { sourceGroupe in
            sourceGroupe.titleGroup == group.titleGroup
        }
    }
    //MARK: IBAction
    @IBAction func unwindSegueToGroup(segue: UIStoryboardSegue) {
        if segue.identifier == fromAllGroupsToGroup,
           let sourceVC = segue.source as? AllGroupsViewController,
           let selectedGroup = sourceVC.selectedGroup {
            if isItemAlreadyArray(group: selectedGroup) { return }
            self.groupArray.append(selectedGroup)
            self.tableView.reloadData()
        }
    }
}
//MARK: Extension GroupViewController
extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    /// numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    /// cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(group: groupArray[indexPath.row])
        return cell
    }
    /// heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    //TODO: Change this metod universal
    /// swipe actions delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [self] (action, sourceView, completionHandler) in
            self.groupArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tableView.reloadData()
    }
    let preventSwipeFullAction = UISwipeActionsConfiguration(actions: [deleteAction ])
    preventSwipeFullAction .performsFirstActionWithFullSwipe = false
    return preventSwipeFullAction
    }
}
//MARK: Extension UISearchBarDelegate
extension GroupViewController: UISearchBarDelegate {
    //TODO: Change this metod universal
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.groupArray = self.savedGroupeArray
        } else {
            self.groupArray = self.savedGroupeArray.filter ({
                $0.titleGroup.lowercased().contains(searchText.lowercased())
            })
        }
        self.tableView.reloadData()
    }
}
