
import UIKit


//MARK: arrayLetter
func arrayLetter<T: AnyObject>(sourceArray: [T], fieldName: KeyPath<T, String>) -> [String] {
    var resultArray = [String]()
    for item in sourceArray {
        let nameLatter = String(item[keyPath: fieldName].prefix(1))
        if !resultArray.contains(nameLatter.lowercased()) {
            resultArray.append(nameLatter.lowercased())
        }
    }
    return resultArray
}

//MARK: arrayByLetter
func arrayByLetter<T: AnyObject>(sourceArray: [T], letter: String, fieldName: KeyPath<T, String>, fieldForSort: KeyPath<T, String>) -> [T] {
    var resultArray = [T]()
    for item in sourceArray {
        let nameLatter = String(item[keyPath: fieldName].prefix(1)).lowercased()
        if nameLatter == letter.lowercased() {
            resultArray.append(item)
        }
    }
    return resultArray.sorted(by: { $0[keyPath: fieldForSort] > $1[keyPath: fieldForSort] })
}
