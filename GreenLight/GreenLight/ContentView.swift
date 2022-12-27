//
//  ContentView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import AVFoundation
import Firebase

struct ContentView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }

            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LogInView()
            } else {
                if authViewModel.currentUser != nil {
                    mainInterfaceView
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewModel())
    }
}

extension ContentView {
    
    var mainInterfaceView: some View {
        TabView(selection: $viewModel.selctedTab) {
            //got rid of text under buttons -- there are only 3 tabs and they are always there, users will remember what they connect to
            HubView(user: authViewModel.currentUser!)
                .tabItem() {
                    Image(systemName: "list.bullet").renderingMode(.template)
                }
                .tag("Hub")
            EventsView(user: authViewModel.currentUser!)
                .tabItem() {
                    Image(systemName: "party.popper").renderingMode(.template)
                }
                .tag("Events")
            ScannerView(user: authViewModel.currentUser!)
                .tabItem() {
                    Image(systemName: "camera.viewfinder").renderingMode(.template)
                }.onDisappear(){
                    if(Property.sharedInstance.flashOn){
                        Property.sharedInstance.flashOn = false
                        toggleFlash()
                    }
                }.onAppear(){
                    if(Property.sharedInstance.flashInScanner){
                        Property.sharedInstance.flashOn = true
                        toggleFlash()
                    }
                }
                .tag("Scanner")
            ManualCheckView(user: authViewModel.currentUser!)
                .tabItem() {
                    Image(systemName: "person.crop.circle.badge.checkmark").renderingMode(.template)
                    //Text("Manual Check")
                }
                .tag("Manual Check")
            SettingsView(user: authViewModel.currentUser!)
                .tabItem() {
                    Image(systemName: "gearshape")
                }
                .tag("Settings")
        }.accentColor(.green)
        //switch this to .tint(.green) when ios 15 becomes the norm
    }
}
