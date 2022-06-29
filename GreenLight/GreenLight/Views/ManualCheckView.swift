//
//  ManualCheck.swift
//  GreenLight
//
//  Created by Jack Desmond on 6/27/22.
//

import SwiftUI

struct ManualCheckView: View {
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    @State var id: String = ""
    @State var color: Int = 0
    @State var reset: Bool = false
    
    var backgroundColor: Color{
        if(color == 0)
        {
            return Color.gray.opacity(0.15);
        }
        else if (color == 1)
        {
            return Color.green.opacity(0.8);
        }
        else if (color == 2)
        {
            return Color.red.opacity(0.8);
        }
        else
        {
            return Color.yellow.opacity(0.8);
        }
    }
    var body: some View {
        NavigationView {
            ZStack{
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Form(content: {
                        Section{
                                Text("Manuel Check")
                                    .font(.custom("Futura-Bold", size: 30))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundColor(Color.green)
                                    .padding()
                               // Text field
                                TextField("Student ID", text: $id)
                               // Button
                                Button("Check") {
                                    reset = true
                                    
                                    if (socialDict.keys.contains(id.uppercased())) {
                                        color = 1
                                    }
                                    else if (blackDict.keys.contains(id.uppercased())){
                                        color = 2
                                    }
                                    else {
                                        color = 3
                                    }
                               }
                                .foregroundColor(Color.green)
                        }
                        if reset {
                            Section {
                                Button("Check Another ID") {
                                    color = 0
                                    reset = false
                                    id = ""
                               }
                                .foregroundColor(Color.green)
                            }
                        }
                    })
                }
            }
        }
    }
}

struct ManualCheckView_Previews: PreviewProvider {
    static var previews: some View {
        ManualCheckView()
    }
}
