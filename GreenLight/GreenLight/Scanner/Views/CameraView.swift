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
    let user: User
    
    init (user: User) {
        self.user = user
    }
    
    func updateUIViewController(_ uiViewController: VisionViewController, context: Context) {
        uiViewController.user = self.user
        uiViewController.fetchUserLists()
        print(self.user.settings)
    }
    
    typealias UIViewControllerType = VisionViewController
    func makeUIViewController(context: Context) -> VisionViewController {
        return VisionViewController(user: self.user)
        }
    
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(user: User(username: "", fullname: "", email: "", uid: "", settings: ["":""]))
    }
}
