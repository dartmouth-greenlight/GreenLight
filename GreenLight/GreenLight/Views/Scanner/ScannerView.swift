//
//  ScannerView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//
import SwiftUI
import AVFoundation


struct ScannerView: View {
    var body: some View {
        VStack{
            ZStack{
                Text("GreenLight")
                    .font(.custom("Futura-Bold", size: 30))
                    .foregroundColor(.green)
            }.frame(height: 45)
            CameraView()
                .ignoresSafeArea()
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
