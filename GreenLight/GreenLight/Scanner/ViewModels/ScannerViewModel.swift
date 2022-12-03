//
//  ScannerViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 11/27/22.
//

import Foundation
import SwiftUI

class ScannerViewModel: ObservableObject {
    @Published var user: User
    let userService = UserService()
    
    
    init(user: User) {
        self.user = user
        self.fetchUser()
    }
    
    func fetchUser() {
        let uid = self.user.uid
        userService.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
}
