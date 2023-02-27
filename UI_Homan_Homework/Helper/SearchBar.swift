

import UIKit

func cornerSearchBar(searchBar: UISearchBar) {
    searchBar.clipsToBounds = true
    searchBar.layer.cornerRadius = 16
}

//func searchBarTest<T>(searchBar: UISearchBar, textDidChange searchText: String, array: inout [T], savedArray: inout[T]) {
//    if searchText.isEmpty {
//        array = savedArray
//    } else {
//        array = savedArray.filter ({
//            $0
//                .titleGroup // первая буква или слово, проверка на содержание
//                .lowercased().contains(searchText.lowercased())
//        })
//    }
//}
