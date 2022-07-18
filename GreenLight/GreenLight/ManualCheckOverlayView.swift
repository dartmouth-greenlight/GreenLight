//
//  ManualCheck.swift
//  GreenLight
//
//  Created by Jack Desmond and Tucker Simpson on 6/27/22.
//


import SwiftUI

//TODO: fix bugginess when viewing in horizontal
//TODO: Switch the input name box with a box that display's the person's name -- make sure doorman didn't have a typo
struct ManualCheckOverlayView: View {
//    init(){
//            UITableView.appearance().backgroundColor = .clear
//        }
    
    @State var id: String = ""
    @State var color: Int = 0
    @State var reset: Bool = false
    @State var string: String = "Manual Check"
    
    var body: some View {
        // Text field
        
        VStack{
            Form(content: {
                Section{
                    Text(string)
                        .font(.custom("Futura-Bold", size: 30))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.green)
                        .padding()
            if (!reset){
                TextField("Student ID", text: $id)
                               
                // Button
                Button("Check") {
                                    
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
                .foregroundColor(Color.green)
                }
                if reset {
                    Section {
                        Button("Check Another ID") {
                            color = 0
                            reset = false
                            id = ""
                            string = "Manual Check"
                                
                        }
                        .foregroundColor(Color.green)
                        }
                }
            }
        })
    }
    }
}


struct ManualCheckOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        ManualCheckOverlayView()
    }
}
