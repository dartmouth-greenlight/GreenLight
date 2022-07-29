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
    init(){
        Property.sharedInstance.flashOn = false
        
    }
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
                Property.sharedInstance.flashOn = false
                Property.sharedInstance.flashInScanner = false
                torchOn = false
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                    Property.sharedInstance.flashOn = true
                    Property.sharedInstance.flashInScanner = true
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
            ZStack{
                Color.gray.opacity(0.15)
                    .ignoresSafeArea()
                Text("GreenLight")
                    .font(.custom("Futura-Bold", size: 40))
                    .foregroundColor(.green)
            }.frame(height: 45)
            ZStack{
                CameraView()
                    .ignoresSafeArea()
                if(!Property.sharedInstance.foundString){
                    Button(){
                        self.toggleFlash()
                    }label:{
                        if torchOn {
                            Image(systemName: "flashlight.on.fill")
                                .font(.system(size: 60, weight: .regular))
                                .foregroundColor(.green)
                        }else{
                            Image(systemName: "flashlight.off.fill")
                                .font(.system(size: 60, weight: .regular))
                                // need to match this color exactly with unselected tabview items
                                .foregroundColor(.gray)
                        }
                    }
                    .offset(x: 0, y: 180)
                }
            }
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
