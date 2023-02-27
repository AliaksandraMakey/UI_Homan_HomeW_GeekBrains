
import UIKit

func forEditingStyle<T: AnyObject>(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle,
                                at indexPath: IndexPath, array: inout [T], fieldID: KeyPath<T, Int>, objRealm: AnyObject) {
    switch editingStyle {
    case .none: break
    case .delete:
        removeObjectFromArrayAndRealm(at: indexPath, array: &array, fieldID: fieldID, objRealm: objRealm)
        tableView.reloadData()
    case .insert: break
    @unknown default:
        print("Error AllGroupsViewController.editingStyle")
    }
}
