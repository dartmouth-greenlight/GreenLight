//
//  AddListViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/12/22.
//

import Foundation
import SwiftUI

class AddListViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var showView = false
    
    func createList(contentViewModel: ContentViewModel) {
        if self.name != "" {
            contentViewModel.addList(name: name)
        }
    }
}
