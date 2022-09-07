
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
        
        let groups = GroupGateway.getGroups()
        groupArray += groups
    }
    
    //MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        
        ///  тень и закругления для аватарки
        userAvatarPhoto.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.shadowColor =  #colorLiteral(red: 0.3123562634, green: 0.663256526, blue: 0.474018991, alpha: 0.8709902732)
        userAvatar.layer.shadowOffset = CGSize(width: -3, height: -3)
        userAvatar.layer.shadowRadius = 10
        userAvatar.layer.shadowOpacity = 1
        userAvatar.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        
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
           let selectedGroupe = sourceVC.selectedGroup {
            if isItemAlreadyArray(group: selectedGroupe) { return }
            self.groupArray.append(selectedGroupe)
            tableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
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
