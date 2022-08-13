//
//  HubViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/9/22.
//

import Foundation
import SwiftUI

class HubViewModel: ObservableObject {
    @Published var isEditing = false
    @Published var showView = false
    
    func onDeletePress(offsets: IndexSet, viewModel: ContentViewModel) {
        viewModel.lists.remove(atOffsets: offsets)
    }

    func onAddPress() {
        showView.toggle()
    }
}
