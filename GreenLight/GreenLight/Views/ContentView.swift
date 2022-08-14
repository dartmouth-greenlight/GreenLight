//
//  ContentView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    let manCheckVM = ManualCheckViewModel()
    
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
            if(viewModel.loggedIn){
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
                ManualCheckView(viewModel: manCheckVM)
                    .tabItem() {
                        Image(systemName:"person.crop.circle.badge.checkmark").renderingMode(.template)
                            //Text("Manual Check")
                    }
                SettingsView()
                    .tabItem(){
                        Image(systemName: "gearshape.fill").renderingMode(.template)
                    }
            }else{
                logInPage()
            }
        }.accentColor(.green)
        .onAppear{
            viewModel.loggedIn = viewModel.isLoggedIn
        }
        
    }
}

struct logInPage: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State var username = ""
    @State var password = ""
    
    var body: some View{
        NavigationView{
            ZStack{
                LinearGradient(colors:[.white, .green], startPoint: .top, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack{
                    Image("logo")
                        .resizable()
                        .padding()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    VStack{
                        TextField("Email", text: $username)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(Color.gray.opacity(0.3))
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(Color.gray.opacity(0.3))
                        
                        Button("Log In"){
                            if(username != "" && password != ""){
                                viewModel.logIn(username: username, pword: password)
                            }
                        }.buttonStyle(RoundedRectangleButtonStyle())
                        
                        Spacer()
                        
                        NavigationLink("Create Account", destination: signUpPage())
                            .buttonStyle(RoundedRectangleButtonStyle())
                        
                    }.padding()
                    
                    Spacer()
                }
                .navigationTitle("Log In")
            }
        }
        
    }
}

struct signUpPage: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State var organization = ""
    @State var username = ""
    @State var password = ""
    
    var body: some View{
        NavigationView{
            ZStack{
                LinearGradient(colors:[.white, .green], startPoint: .top, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding()
                    VStack{
                        
                        // potentially make this a drop-down menu of all the different fraternities / sororities
                        TextField("Organization Name", text: $organization)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(Color.gray.opacity(0.3))
                        
                        TextField("Email", text: $username)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(Color.gray.opacity(0.3))
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(Color.gray.opacity(0.3))
                        
                        Button("Sign Up"){
                            if(username != "" && password != "" && organization != ""){
                                viewModel.signUp(username: username, pword: password, org: organization)
                            }
                        }.buttonStyle(RoundedRectangleButtonStyle())
                            .padding()
                                            
                    }.padding()
                    
                    Spacer()
                }
                .navigationTitle("Create Account")
            }
        }
        
    }
}

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label.foregroundColor(.black)
      Spacer()
    }
    .padding()
    .background(Color.green.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        signUpPage()
            .environmentObject(ContentViewModel())
    }
}
