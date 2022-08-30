//
//  GroupViewController.swift
//  UI_Homan_Homework
//
//  Created by aaa on 26.05.22.
//

import UIKit

class GroupViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userAvatar: UIView!
    @IBOutlet weak var userAvatarPhoto: UIView!
    @IBOutlet weak var searchBarMyGroups: UISearchBar!
    
    // создаем массив с группами
    var groupeArray = [Group]()
    
    //    func fillgroupeArray() {
        //        let groupeOne = Group(titleGroup: "Hogwarts School", avatarPhoto: UIImage(named: "Hogwarts")!)
        //        groupeArray.append(groupeOne)
        //    }
    
    
    
    //MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
//    //MARK: viewWillAppear
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        tableView.reloadData()
//    }
    
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
//        avatarImage.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        userAvatar.layer.shadowOffset = CGSize(width: -3, height: -3)
        userAvatar.layer.shadowRadius = 10
        userAvatar.layer.shadowOpacity = 1
        userAvatar.layer.cornerRadius = CGFloat(cellHeight / 2 - 8)
        ///  закругления для searchBar
        searchBarMyGroups.clipsToBounds = true
        searchBarMyGroups.layer.cornerRadius = 16
  
    }
    
    // создадим функцию сортировки групп, отвечающюуся за неповторение в group одинаковых групп из allGroups
    func isItemAlreadyArray(group: Group) -> Bool {
        return groupeArray.contains { sourceGroupe in
            sourceGroupe.titleGroup == group.titleGroup
        }
    }


    @IBAction func unwindSegueToGroup(segue: UIStoryboardSegue) {
        // добавим условие для segue
        if segue.identifier == fromAllGroupsToGroup,
           let sourceVC = segue.source as? AllGroupsViewController,
           let selectedGroupe = sourceVC.selectedGroup
        {
            if isItemAlreadyArray(group: selectedGroupe) { return }
            self.groupeArray.append(selectedGroupe)
            tableView.reloadData()
        }
    }
}

//MARK: Extension
extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
      
        performSegue(withIdentifier: fromAllGroupsToGroup, sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // возвращаем массив, выведенный построчно ( .count )
        return groupeArray.count
    }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
          // аналогично указываем массив
          cell.configure(group: groupeArray[indexPath.row])
          
          return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
}

////  MARK: searchBar
//    var savedGroupeArray = [Group]()
//
//    func arrayLetter(sourceArray: [Group]) -> [String] {
//        var resultArray = [String]()
//        for item in sourceArray {
//            let nameLatter = String(item.titleGroup.prefix(1))
//            if !resultArray.contains(nameLatter.lowercased()) {
//                resultArray.append(nameLatter.lowercased())
//            }
//        }
//        return resultArray
//    }
//
//    func arrayByLetter(sourceArray: [Group], letter: String) -> [Group] {
//        var resultArray = [Group]()
//        for item in sourceArray {
//            let nameLatter = String(item.titleGroup.prefix(1)).lowercased()
//            if nameLatter == letter.lowercased() {
//                resultArray.append(item)
//            }
//        }
//        return resultArray.sorted(by: { $0.titleGroup > $1.titleGroup })
//    }
//
//    func groupeArrayBySectionIndexAndRowIndex(section: Int, row: Int) -> Group {
//        return arrayByLetter(sourceArray: groupeArray, letter: arrayLetter(sourceArray: groupeArray)[section])[row]
//    }
//
