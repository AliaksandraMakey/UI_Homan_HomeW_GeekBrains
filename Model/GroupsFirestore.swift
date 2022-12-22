
import Foundation
import FirebaseFirestore


 let db = Firestore.firestore()

struct GroupsFirestore: Decodable {
    let groupIds: [Int]
}
    public func  getGroupIdFirestore(groupIds: @escaping ([Int]) -> Void) {
        db
            .collection("userGroups")
            .document(String(Session.instance.userId!))
            .getDocument { snapshot, error in
                print(error as Any)
                
                guard let dataDict = snapshot?.data(),
                      let data = try? JSONSerialization.data(withJSONObject: dataDict, options: .fragmentsAllowed),
                      let groupFirestore = try? JSONDecoder().decode(GroupsFirestore.self, from: data)
                else  { return }
                
                groupIds(groupFirestore.groupIds)
            }
    }
