//
//  ScannerView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//
import SwiftUI
import AVFoundation


struct ScannerView: View {
    @State var torchOn = false
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
                torchOn = false
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                    torchOn = true
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
        VStack{
            Text("GreenLight")
                .font(.custom("Futura-Bold", size: 40))
                .foregroundColor(.green)
                .frame(height: 40)
            ZStack{
                CameraView()
                    .ignoresSafeArea()
                Button(){
                    self.toggleFlash()
                }label:{
                    if torchOn {
                        Image(systemName: "flashlight.on.fill")
                            .font(.system(size: 60, weight: .regular))
                    }else{
                        Image(systemName: "flashlight.off.fill")
                            .font(.system(size: 60, weight: .regular))
                    }
                }
                .offset(x: 0, y: 180)
            }
        }
        
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
