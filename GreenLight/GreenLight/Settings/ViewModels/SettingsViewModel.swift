//
//  SettingsViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 11/26/22.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var lists = [ListGL]()
    @Published var greenListId: String
    @Published var redListId: String
    var user: User
    let listService = ListService()
    let userService = UserService()
    
    
    init(user: User) {
        self.user = user
        self.greenListId = user.settings["greenListId"]!
        self.redListId = user.settings["redListId"]!
        self.fetchUserSettings()
        self.fetchUserLists()
    }
    
    func fetchUserLists() {
        guard let uid = user.id else { return }
        listService.fetchLists(forUid: uid) { lists in
            self.lists = lists
        }
    }
    
    func fetchUserSettings() {
        let uid = self.user.uid
        userService.fetchUser(withUid: uid) { user in
            self.user = user
            self.greenListId = user.settings["greenListId"]!
            self.redListId = user.settings["redListId"]!
        }
    }
    
    func updateUserSettings() {
        guard let uid = user.id else { return }
        userService.updateSettings(forUid: uid, greenListId: greenListId, redListId: redListId) { success in
            if success == false {
                print("Failed to update user settings")
            }
        }
    }
}

