//
//  ManualCheckViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/9/22.
//

import Foundation
import SwiftUI

class ManualCheckViewModel: ObservableObject{
    @Environment(\.colorScheme) var colorScheme
    
    @Published var color = 0
    @Published var reset = false
    @Published var bannerTitle = "Manual Check"
    @Published var id = ""
    @Published var greenList = [String:String]()
    @Published var redList = [String:String]()
    
    var user: User
    let listService = ListService()
    let userService = UserService()
    
    
    init(user: User) {
        self.user = user
        self.fetchUser()
    }
    
    func fetchUser() {
        let uid = self.user.uid
        userService.fetchUser(withUid: uid) { user in
            self.user = user
            self.fetchUserLists()
        }
    }
    
    func fetchUserLists() {
        if user.settings["greenListId"]! != "None" {
            listService.fetchList(forListId: user.settings["greenListId"]!) { list in
                self.greenList = list.names
            }
        }
        if user.settings["redListId"]! != "None" {
            listService.fetchList(forListId: user.settings["redListId"]!) { list in
                self.redList = list.names
            }
        }
    }
    
    var backgroundColor: Color{
        if(color == 0)
        {
            if (colorScheme == .light) {
                return Color(UIColor.secondarySystemBackground);
            }
            else {
                return Color(.black)
            }
        }
        else if (color == 1)
        {
            return Color.green;
        }
        else if (color == 2)
        {
            return Color.red;

        }
        else
        {
            return Color.yellow
        }
    }
        
    func checkID (stuID: String) {
        if(id != ""){
            self.reset = true
            if (self.greenList.keys.contains(stuID.lowercased())) {
                bannerTitle = greenList[stuID.lowercased()]!
                color = 1
            }
            else if (self.redList.keys.contains(stuID.lowercased())){
                self.bannerTitle = redList[stuID.lowercased()]!
                self.color = 2
            }
            else {
                self.bannerTitle = getName(id: stuID.uppercased())
                self.color = 3
            }
        }
    }
    
    func resetVars(){
        color = 0
        reset = false
        id = ""
        bannerTitle = "Manual Check"
    }
}
