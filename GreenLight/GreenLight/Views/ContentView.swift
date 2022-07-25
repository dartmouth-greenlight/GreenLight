//
//  ContentView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var lists: Lists
    
    var body: some View {
        TabView{
            ScannerView()
                .tabItem() {
                    Image(systemName: "camera.viewfinder")
                    Text("Scanner")
                }
            HubView()
                .tabItem() {
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text("Lists")
                }
            ManualCheckView()
                .tabItem() {
                    Image(systemName: "person.text.rectangle")
                    Text("Manual Check")
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
