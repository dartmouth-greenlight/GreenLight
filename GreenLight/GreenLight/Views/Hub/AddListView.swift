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
    @Environment(\.presentationMode) var presentationMode
    
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
                    if #available(iOS 15.0, *) {
                        TextField("List Name", text: $name)
                            .onSubmit {
                                if name != "" {
                                    lists.lists.append(GreenLightList(name: name, list: []))
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                    } else {
                        TextField("List Name", text: $name)
                    }
                    // Button
                    Button("Create List") {
                        showView.toggle()
                        //TODO: make sure there are no lists with the same name
                        if name != "" {
                            lists.lists.append(GreenLightList(name: name, list: []))
                            presentationMode.wrappedValue.dismiss()
                        }
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
