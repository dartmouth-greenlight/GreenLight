//
//  ContentView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
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
