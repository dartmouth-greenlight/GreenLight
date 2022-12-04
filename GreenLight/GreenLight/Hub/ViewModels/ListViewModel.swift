//
//  ListViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/9/22.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var isEditing = false
    @Published var showView = false
    @Published var list: ListGL
    @Published var ids: [String]
    @Published var didDeleteList = false
    @Published var refresh = false
    
    let service = ListService()
    
    init(list: ListGL) {
        self.list = list
        self.ids = list.ids
        self.fetchUpdatedList()
        
    }
    
    
    func fetchUpdatedList() {
        guard let listId = list.id else { return }
        service.fetchList(forListId: listId) { list in
            self.list = list
            self.ids = list.ids
        }
    }
    
    func onDeletePress(offsets: IndexSet) {
        offsets.forEach { index in
            let id = self.list.ids[index]
            service.removeFromList(forList: self.list, id: id) { success in
                if success {
                    self.didDeleteList = true
                }
            }
            
        }
        ids.remove(atOffsets: offsets)
    }
    
    func onAddPress() {
        showView.toggle()
    }
}
