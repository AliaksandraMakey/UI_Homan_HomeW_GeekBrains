//
//  AllGroupsArray.swift
//  UI_Homan_Homework
//
//  Created by aaa on 04.06.22.
//

import UIKit

extension AllGroupsViewController {
    
    func fillallGroupeArray() {
        let groupeOne = Group(titleGroup: "Hogwarts School", avatarPhoto: UIImage(named: "Hogwarts")!)
        allGroupeArray.append(groupeOne)
        
        let groupeTwo = Group(titleGroup: "Gryffindor", avatarPhoto: UIImage(named: "1_6")!)
        allGroupeArray.append(groupeTwo)
        
        let groupeThree = Group(titleGroup: "Slytherin", avatarPhoto: UIImage(named: "1_7")!)
        allGroupeArray.append(groupeThree)
        
        let groupeFoure = Group(titleGroup: "Hufflepuff", avatarPhoto: UIImage(named: "1_9")!)
        allGroupeArray.append(groupeFoure)
        
        let groupeFive = Group(titleGroup: "Ravenclaw", avatarPhoto: UIImage(named: "1_8")!)
        allGroupeArray.append(groupeFive)
    }
}
 
