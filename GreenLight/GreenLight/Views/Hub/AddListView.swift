//
//  AddListView.swift
//  GreenLight
//
//  Created by Jack Desmond on 7/22/22.
//

import SwiftUI


@available(iOS 15.0, *)
struct AddListView: View {
    @ObservedObject var viewModel: AddListViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss
    
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
                    TextField("List Name", text: $viewModel.name)
                        .onSubmit {
                            if viewModel.name != "" {
                                viewModel.createList(contentViewModel: contentViewModel)
                                dismiss()
                        }
                    }
                    // Button
                    Button("Create List") {
                        //TODO: make sure there are no lists with the same name
                        if viewModel.name != "" {
                            viewModel.createList(contentViewModel: contentViewModel)
                            dismiss()
                        }
                   }
                    .foregroundColor(Color.green)

                }
            })
        }
    }
}

struct AddListViewDepreciated: View {
    @ObservedObject var viewModel: AddListViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
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
                    TextField("List Name", text: $viewModel.name)
                    // Button
                    Button("Create List") {
                        //TODO: make sure there are no lists with the same name
                        if viewModel.name != "" {
                            viewModel.createList(contentViewModel: contentViewModel)
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
        if #available(iOS 15.0, *) {
            AddListView(viewModel: AddListViewModel())
        } else {
            AddListViewDepreciated(viewModel: AddListViewModel())
        }
    }
}
