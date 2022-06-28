//
//  CameraView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import AVFoundation
import Vision

struct CameraView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: VisionViewController, context: Context) {
    }
    
    typealias UIViewControllerType = VisionViewController
    func makeUIViewController(context: Context) -> VisionViewController {
            return VisionViewController()
        }
    
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
