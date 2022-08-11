//
//  ListViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/9/22.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var editMode = EditMode.inactive
    @Published var names: [Person]
    @Published var title: String
    
    init(title: String, names: [Person]) {
        self.title = title
        self.names = names
    }
    
    func onDeletePress(offsets: IndexSet) {
        self.names.remove(atOffsets: offsets)
    }
}
