
import UIKit

class AllGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userAvatar: UIView!
    @IBOutlet weak var userAvatarPhoto: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var searchBarAllGroups: UISearchBar!
    
    // создаем массив с группами
    var allGroupeArray = [Group]()
    var selectedGroup: Group?
    
    //MARK: viewDidAppear
    // добавим метод, чтобы при переходе на контроллер, происходило обновление tableView
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillAllGroupeArray()
        savedAllGroupeArray = allGroupeArray
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        searchBarAllGroups.delegate = self
        
        ///  тень и закругления для аватарки
        userAvatarPhoto.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.shadowColor =  #colorLiteral(red: 0.3123562634, green: 0.663256526, blue: 0.474018991, alpha: 0.8709902732)
        avatarImage.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.shadowOffset = CGSize(width: -3, height: -3)
        userAvatar.layer.shadowRadius = 10
        userAvatar.layer.shadowOpacity = 1
        userAvatar.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        ///  закругления для searchBar
        searchBarAllGroups.clipsToBounds = true
        searchBarAllGroups.layer.cornerRadius = 16
    }
    
    //MARK: searchBar
    var savedAllGroupeArray = [Group]()
    func arrayLetter(sourceArray: [Group]) -> [String] {
        var resultArray = [String]()
        for item in sourceArray {
            let nameLatter = String(item.titleGroup.prefix(1))
            if !resultArray.contains(nameLatter.lowercased()) {
                resultArray.append(nameLatter.lowercased())
            }
        }
        return resultArray
    }
    
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
}

//MARK: Extension AllGroupsViewController
extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // возвращаем массив, выведенный построчно ( .count )
        return allGroupeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        // аналогично указываем массив
        cell.configure(group: allGroupeArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    // добавим функцию для segue, чтобы при нажатии на элемент коллекции она возвращала нас нас на предыдущий view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedGroup =  allGroupeArray[indexPath.row]
        performSegue(withIdentifier: fromAllGroupsToGroup, sender: nil)
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
