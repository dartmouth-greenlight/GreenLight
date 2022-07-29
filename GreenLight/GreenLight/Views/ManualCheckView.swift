//
//  ManualCheck.swift
//  GreenLight
//
//  Created by Jack Desmond and Tucker Simpson on 6/27/22.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//TODO: fix bugginess when viewing in horizontal
//TODO: Switch the input name box with a box that display's the person's name -- make sure doorman didn't have a typo
struct ManualCheckView: View {
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    @State var id: String = ""
    @State var color: Int = 0
    @State var reset: Bool = false
    @State var string: String = "Manual Check"
    
    var backgroundColor: Color{
        if(color == 0)
        {
            return Color.clear;
        }
        
        else if (color == 1)
        {
            //return Color.green.opacity(0.8);
            return Color.green;
        }
        
        else if (color == 2)
        {
            //return Color.red.opacity(0.8);
            return Color.red;
        }
        
        else
        {
            return Color.yellow
            //return Color.yellow.opacity(0.8);
        }
    }
    
    var background: some View{
        backgroundColor
            .ignoresSafeArea()
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
                background.onTapGesture {
                    hideKeyboard()
                }
                Form(content: {
                    Section{
                        Text(string)
                            .font(.custom("Futura-Bold", size: 30))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color.white)
                            .padding()
                        // Text field
                        if (!reset){
                            if #available(iOS 15.0, *) {
                                TextField("Student ID", text: $id)
                                    .disableAutocorrection(true)
                                    .onSubmit {
                                        hideKeyboard()
                                        if(id != ""){
                                            reset = true
                                            if (socialDict.keys.contains(id.uppercased())) {
                                                string = socialDict[id.uppercased()]!
                                                color = 1
                                            }
                                            else if (blackDict.keys.contains(id.uppercased())){
                                                string = blackDict[id.uppercased()]!
                                                color = 2
                                            }
                                            else {
                                                string = getName(id: id)
                                                color = 3
                                            }
                                        }
                                    }
                            } else {
                                TextField("Student ID", text: $id)
                                    .disableAutocorrection(true)
                            }

                            // Button
                            Button("Check") {
                                hideKeyboard()
                                
                                if(id != ""){
                                    reset = true
                                    if (socialDict.keys.contains(id.uppercased())) {
                                        string = socialDict[id.uppercased()]!
                                        color = 1
                                    }
                                    else if (blackDict.keys.contains(id.uppercased())){
                                        string = blackDict[id.uppercased()]!
                                        color = 2
                                    }
                                    else {
                                        string = getName(id: id)
                                        color = 3
                                    }
                                }
                            }
                            .foregroundColor(Color.white)
                        }
                    }
                    if reset {
                        Section {
                            Button("Check Another ID") {
                                color = 0
                                reset = false
                                id = ""
                                string = "Manual Check"
                            }
                            .foregroundColor(Color.white)
                        }
                    }
                }).padding()
            }
        }
    }
}

struct ManualCheckView_Previews: PreviewProvider {
    static var previews: some View {
        ManualCheckView()
    }
}

