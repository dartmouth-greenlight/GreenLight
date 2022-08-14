//
//  ManualCheck.swift
//  GreenLight
//
//  Created by Jack Desmond and Tucker Simpson on 6/27/22.
//

import SwiftUI


struct ManualCheckView: View {
    @ObservedObject var viewModel: ManualCheckViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            banner
            ZStack{
                viewModel.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        hideKeyboard()
                    }
                VStack{
                    checkerBox
                        .frame(width: 350, height: 200, alignment: .top)
                        .padding(.top, 30.0)
                    Spacer()
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
            .font(.custom("Futura-Bold", size: 30))
            .foregroundColor(.green)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
    }
    
    var checkerBox: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .colorInvert()
            VStack{
                nameOrManualCheck
                if (!viewModel.reset){
                    TextField("Student ID", text: $viewModel.id)
                        .padding(10.0)
                        .background(Color(UIColor.systemGray))
                        .padding(.horizontal)
                    
                    // Button
                    Button("Check") {
                        viewModel.checkID(stuID: viewModel.id)
                    }.buttonStyle(RoundedRectangleButtonStyle())
                        .padding(.horizontal, 30.0)
                }else{
                    Button("Check Another ID") {
                        viewModel.resetVars()
                    }.buttonStyle(RoundedRectangleButtonStyle())
                        .padding(.horizontal, 30.0)
                }
            }
        }
    }
}


extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}


struct ManualCheckView_Previews: PreviewProvider {
    static var previews: some View {
        let manCheckVM2 = ManualCheckViewModel()
        ManualCheckView(viewModel: manCheckVM2)
            .preferredColorScheme(.dark)
    }
}

