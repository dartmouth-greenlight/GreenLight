//
//  SettingsView.swift
//  GreenLight
//
//  Created by Jack Desmond on 11/13/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: SettingsViewModel
    
    init(user: User) {
        self.viewModel = SettingsViewModel(user: user)
    }
    
    var body: some View {
        NavigationView() {
            VStack {
                Form(content: {
                    Section(header: Text("Scanner")) {
                        Picker("Event", selection: $viewModel.eventId) {
                            Text("None").tag("None")
                            ForEach(viewModel.events) { event in
                                Text(event.title).tag(event.id!)
                            }
                        }
                        Picker("Green List", selection: $viewModel.greenListId) {
                            Text("None").tag("None")
                            ForEach(viewModel.lists) { list in
                                Text(list.title).tag(list.id!)
                            }
                        }
                        Picker("Red List", selection: $viewModel.redListId) {
                            Text("None").tag("None")
                            ForEach(viewModel.lists) { list in
                                Text(list.title).tag(list.id!)
                            }
                        }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Button {
                            authViewModel.signOut()
                        } label: {
                            Text("Sign Out")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 240, height: 50)
                                .background(Color(.systemGreen))
                                .clipShape(Capsule())
                                .padding()
                        }
                        .shadow(color: .gray.opacity(0.5), radius: 10)
                        .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .listRowInsets(EdgeInsets())
                    .background(Color(UIColor.systemGroupedBackground))
                })
                .navigationTitle(Text("Settings"))
                .onChange(of: viewModel.greenListId) { _ in
                    viewModel.updateUserSettings()
                }
                .onChange(of: viewModel.redListId) { _ in
                    viewModel.updateUserSettings()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: User(username: "", fullname: "", email: "", uid: "", settings: ["greenListId":"", "redListId":""]))
    }
}
