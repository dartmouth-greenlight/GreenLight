//
//  ScannerView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import AVFoundation


struct ScannerView: View {
    @State private var keyboardHeight: CGFloat = 0
    var body: some View {
        ZStack{
            CameraView()
                .ignoresSafeArea()
            ManualCheckOverlayView()
                .offset(y:400-keyboardHeight)
                .padding(.bottom, 15 + keyboardHeight)
        }
        .padding(.bottom, keyboardHeight)
        //.onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
