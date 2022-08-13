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
    @Published var list: GreenLightList
    @Published var title: String
    
    init(list: GreenLightList) {
        self.title = list.name
        self.list = list
    }
    
    func onDeletePress(offsets: IndexSet) {
        self.list.list.remove(atOffsets: offsets)
    }
    
    func onAddPress() {
        showView.toggle()
    }
}
