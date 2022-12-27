//
//  AddEventView.swift
//  GreenLight
//
//  Created by Jack Desmond on 12/11/22.
//

import SwiftUI


@available(iOS 15.0, *)
struct AddEventView: View {
    @ObservedObject var viewModel: AddEventViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Form(content: {
                Section{
                    Text("Create an Event")
                        .font(.custom("Futura-Bold", size: 30))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.green)
                        .padding()
                    // Text field
                    TextField("Event Name", text: $viewModel.name)
                    // Button
                    Button("Create Event") {
                        //TODO: make sure there are no lists with the same name
                        if viewModel.name != "" {
                            viewModel.createEvent(withTitle: viewModel.name)
                        }
                        contentViewModel.refreshView()
                   }
                    .foregroundColor(Color.green)

                }
            })
        }
        .onReceive(viewModel.$didCreateEvent) { success in
            if success {
                dismiss()
            }
        }
    }
}

struct AddEventViewDepreciated: View {
    @ObservedObject var viewModel: AddEventViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Form(content: {
                Section{
                    Text("Create an Event")
                        .font(.custom("Futura-Bold", size: 30))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.green)
                        .padding()
                    // Text field
                    TextField("Event Name", text: $viewModel.name)
                    // Button
                    Button("Create Event") {
                        //TODO: make sure there are no lists with the same name
                        if viewModel.name != "" {
                            viewModel.createEvent(withTitle: viewModel.name)
                        }
                   }
                    .foregroundColor(Color.green)

                }
            })
        }
        .onReceive(viewModel.$didCreateEvent) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            AddEventView(viewModel: AddEventViewModel())
        } else {
            AddEventViewDepreciated(viewModel: AddEventViewModel())
        }
    }
}
