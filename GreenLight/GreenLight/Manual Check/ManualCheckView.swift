//
//  ManualCheck.swift
//  GreenLight
//
//  Created by Jack Desmond and Tucker Simpson on 6/27/22.
//

import SwiftUI

//TODO: fix bugginess when viewing in horizontal
//TODO: Switch the input name box with a box that display's the person's name -- make sure doorman didn't have a typo
struct ManualCheckView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: ManualCheckViewModel
    
    @State var id: String = ""
    @State var color: Int = 0
    @State var reset: Bool = false
    @State var string: String = "Manual Check"
    @Environment(\.colorScheme) var colorScheme
    
    init(user: User) {
        self.viewModel = ManualCheckViewModel(user: user)
    }
    
    
    var body: some View {
        VStack{
            banner
            ZStack{
                viewModel.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                //TODO: ? replace this with a rounded rectangle z-stack v-stack so it doesn't take up the whole page
                VStack {
                    VStack {
                        VStack {
                            nameOrManualCheck
                            // Text field
                            if (!viewModel.reset){
                                TextField("Student ID", text: $viewModel.id)
                                    .padding(.vertical,12)
                                    .overlay(Divider(), alignment: .top)
                                    .overlay(Divider(), alignment: .bottom)
                                    .padding(.horizontal,10)
                                    .autocapitalization(.none)
                                
                                // Button
                                HStack {
                                    Button(action: {
                                        viewModel.checkID(stuID: viewModel.id)
                                    }, label: {
                                        HStack {
                                            Text("Check")
                                                .foregroundColor(.green)
                                                .padding(.horizontal,10)
                                                .padding(.vertical,4)
                                            Spacer()
                                        }
                                    })
                                }
                            }
                        }
                        .padding(10)
                    }
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.vertical)
                    
                    if viewModel.reset {
                        VStack {
                            Button(action: {
                                viewModel.resetVars()
                            }) {
                                HStack {
                                    Text("Check another ID")
                                        .foregroundColor(.green)
                                        .padding(.horizontal,10)
                                        .padding(.vertical,4)
                                    Spacer()
                                }
                                .padding(10)
                            }
                        }
                        .background(.white)
                        .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding(30)
            }
        }
    }
    
    var banner: some View{
        ZStack{
            Text("GreenLight")
                .font(.custom("Futura-Bold", size: 30))
                .foregroundColor(.green)
        }.frame(height: 45)
    }
    
    var nameOrManualCheck: some View{
        Text(viewModel.bannerTitle)
            .font(.custom("Futura-Bold", size: 20))
            .foregroundColor(.green)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
    }
}


struct ManualCheckView_Previews: PreviewProvider {
    
    static var previews: some View {
        ManualCheckView(user: User(username: "", fullname: "", email: "", uid: "", settings: ["":""]))
    }
}

