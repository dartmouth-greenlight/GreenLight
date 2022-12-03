//
//  GreenLightApp.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import Firebase

@main
struct GreenLightApp: App {
    @StateObject var contentViewModel = ContentViewModel()
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(contentViewModel)
            .environmentObject(authViewModel)
        }
    }
}
