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
    @Published var didCreateList = false
    
    let service = ListService()
    
    func createList(withTitle title: String) {
        if self.name != "" {
            service.uploadList(title: title) { success in
                if success {
                    self.didCreateList = true
                }
            }
        }
    }
}
