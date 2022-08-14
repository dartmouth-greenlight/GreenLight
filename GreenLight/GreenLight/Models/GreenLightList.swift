//
//  GreenLightList.swift
//  GreenLight
//
//  Created by Jack Desmond on 7/15/22.
//

import Foundation
import SwiftUI

struct GreenLightList: Identifiable {
    let id = NSDate().timeIntervalSince1970
    var name: String
    var list: Array<Person>
    var dict: [String: String]
    
    func contains(uid: String) -> Bool {
        let uid = uid.uppercased()
        if(self.dict[uid] != nil){
            return true
        }else{
            return false
        }
    }
    
//    func addToList(_ person: Person){
//        list.append(person)
//        dict[person.id] = person.name
//    }

}
