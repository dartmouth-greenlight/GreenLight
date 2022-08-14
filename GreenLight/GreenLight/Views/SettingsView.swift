//
//  SettingsView.swift
//  GreenLight
//
//  Created by Tucker Simpson on 8/13/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                //Add: password reset
                NavigationLink(destination: ContentView()) {
                    Text("Sign Out")
                }.simultaneousGesture(TapGesture().onEnded{
                    viewModel.signOut()
                }).buttonStyle(RoundedRectangleButtonStyle())
                    .navigationTitle("Settings")
                    .padding()
                
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
