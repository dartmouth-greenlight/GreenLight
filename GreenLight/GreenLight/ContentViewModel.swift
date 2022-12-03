//
//  ContentViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/9/22.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var onManualCheckView = false
    @Published var selctedTab = "Hub"
    @Published var refresh = false
    
    
    func refreshView() {
        self.refresh.toggle()
    }
}
