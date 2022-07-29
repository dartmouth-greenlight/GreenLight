//
//  ContentView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var onManualCheckView = false
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
        TabView{
            //got rid of text under buttons -- there are only 3 tabs and they are always there, users will remember what they connect to
            ScannerView()
                .tabItem() {
                    Image(systemName: "camera.viewfinder").renderingMode(.template)
                    //Text("Scanner")
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
            HubView()
                .tabItem() {
                    Image(systemName: "list.bullet").renderingMode(.template)
                    //Text("Lists")
                }
            ManualCheckView()
                .tabItem() {
                    Image(systemName: "person.crop.circle.badge.checkmark").renderingMode(.template)
                    //Text("Manual Check")
                }
//                .onAppear(){
//                    Property.sharedInstance.onManualCheckView = true
//                }
        }.accentColor(.green)
        //switch this to .tint(.green) when ios 15 becomes the norm
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
