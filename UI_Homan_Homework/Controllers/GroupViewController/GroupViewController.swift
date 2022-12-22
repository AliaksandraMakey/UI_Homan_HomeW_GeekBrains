
import UIKit
import RealmSwift
import FirebaseFirestore

class GroupViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userAvatar: UIView!
    @IBOutlet weak var userAvatarPhoto: UIView!
    @IBOutlet weak var searchBarMyGroups: UISearchBar!
    
    private var realmNotification: NotificationToken?
    
    var groupArray = [Group]()
    
    func fillgroupArray() {
//        DispatchQueue.global().async {
            getGroupIdFirestore { groupIds in
                let groups = GroupGateway.getGroups(ids: groupIds)
                self.groupArray += groups
                self.tableView.reloadData()
//            }
        }
        
    }
    
    //MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fillgroupArray()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifierCustom")
        tableView.delegate = self
        tableView.dataSource = self
        
        userAvatarCustom(avatarPhoto: userAvatarPhoto, avatarSubview: userAvatar)
        
        ///  закругления для searchBar
        searchBarMyGroups.clipsToBounds = true
        searchBarMyGroups.layer.cornerRadius = 16
        
    }
    
    func isItemAlreadyArray(group: Group) -> Bool {
        return groupArray.contains { sourceGroupe in
            sourceGroupe.titleGroup == group.titleGroup
        }
    }
    
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
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        performSegue(withIdentifier: fromAllGroupsToGroup, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifierCustom", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(group: groupArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { [self] (action, IndexPath) in
            self.groupArray.remove(at: IndexPath.row)
            tableView.deleteRows(at: [IndexPath as IndexPath], with: .fade)
        })
        deleteAction.backgroundColor = #colorLiteral(red: 0.05872806162, green: 0.1163934693, blue: 0.08317165822, alpha: 1)
        return [deleteAction]
    }
}
