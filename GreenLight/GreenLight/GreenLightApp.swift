//
//  GreenLightApp.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import FirebaseCore

@main
struct GreenLightApp: App {
    
    @StateObject var contentViewModel: ContentViewModel = ContentViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(contentViewModel)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

