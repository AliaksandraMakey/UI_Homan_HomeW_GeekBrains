//
//  AllGroupsArray.swift
//  UI_Homan_Homework
//
//  Created by aaa on 04.06.22.
//

import UIKit

extension AllGroupsViewController {
    
    func fillallGroupeArray() {
        let realmGroups = getAllRealmGroups()
        var groupe: [Group] = realmGroups.map {  item in
            
            var groupe = Group()
            groupe.titleGroup = item.name
            groupe.avatarPhoto = UIImage(data: item.data!) ?? UIImage()
            return groupe
        }
        allGroupeArray += groupe
        
        allGroupeArray = allGroupeArray.sorted(by: { $0.titleGroup < $1.titleGroup })
    }
}

