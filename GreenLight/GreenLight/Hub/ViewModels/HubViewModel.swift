//
//  HubViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/9/22.
//

import Foundation
import SwiftUI

class HubViewModel: ObservableObject {
    @Published var lists = [ListGL]()
    @Published var showView = false
    @Published var didDeleteList = false
    let user: User
    let service = ListService()
    
    
    init(user: User) {
        self.user = user
        self.fetchUserLists()
    }
    
    func fetchUserLists() {
        guard let uid = user.id else { return }
        service.fetchLists(forUid: uid) { lists in
            self.lists = lists
        }
    }
    
    func onDeletePress(offsets: IndexSet) {
        offsets.forEach { index in
            let list = self.lists[index]
            service.deleteList(forList: list) { success in
                if success {
                    self.didDeleteList = true
                }
            }
            
        }
        lists.remove(atOffsets: offsets)
    }

    func onAddPress() {
        showView.toggle()
    }
}
