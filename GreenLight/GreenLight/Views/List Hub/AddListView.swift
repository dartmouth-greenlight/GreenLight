//
//  AddListView.swift
//  GreenLight
//
//  Created by Jack Desmond on 7/22/22.
//

import SwiftUI

struct AddListView: View {
    @State var name: String = ""
    @State var showView = false
    @EnvironmentObject var lists: Lists
    
    var body: some View {
        VStack{
            Form(content: {
                Section{
                    Text("Create a List")
                        .font(.custom("Futura-Bold", size: 30))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.green)
                        .padding()
                    // Text field
                    TextField("List Name", text: $name)
                   
                    // Button
                    Button("Create List") {
                        showView.toggle()
                        lists.lists.append(GreenLightList(name: name, list: []))
                   }
                    .foregroundColor(Color.green)

                }
            })
        }
    }
}

struct AddListView_Previews: PreviewProvider {
    static var previews: some View {
        AddListView()
    }
}
