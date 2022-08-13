//
//  ManualCheck.swift
//  GreenLight
//
//  Created by Jack Desmond and Tucker Simpson on 6/27/22.
//

import SwiftUI

//TODO: Switch the input name box with a box that display's the person's name -- make sure doorman didn't have a typo
struct ManualCheckView: View {
    @ObservedObject var viewModel: ManualCheckViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            banner
            ZStack{
                viewModel.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                Form {
                    Section{
                        nameOrManualCheck
                        // Text field
                        if (!viewModel.reset){
                            TextField("Student ID", text: $viewModel.id)
                            
                            // Button
                            Button("Check") {
                                viewModel.checkID(stuID: viewModel.id)
                            }
                        }
                    }
                    if viewModel.reset {
                        Section {
                            Button("Check Another ID") {
                                viewModel.resetVars()
                            }
                        }
                    }
                }
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
        let manCheckVM2 = ManualCheckViewModel()
        ManualCheckView(viewModel: manCheckVM2)
            .preferredColorScheme(.dark)
    }
}

