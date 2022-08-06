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
                Color.gray.opacity(0.15)
                    .ignoresSafeArea()
                Text("GreenLight")
                    .font(.custom("Futura-Bold", size: 36))
                    .foregroundColor(.green)
            }.frame(height: 45)
            ZStack{
                CameraView()
                    .ignoresSafeArea()
            }
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
