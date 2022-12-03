//
//  HubView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI

struct HubView: View {
    @ObservedObject var viewModel: HubViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    init(user: User) {
        self.viewModel = HubViewModel(user: user)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    List() {
                        ForEach(viewModel.lists) { list in
                            NavigationLink {
                                ListView(list: list)
                            } label: {
                                ListRow(list: list)
                            }
                        }
                        .onDelete(perform: deleteButtonPress)
                    }
                    .listStyle(.insetGrouped)
                }
                Button(action: {
                    viewModel.onAddPress()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20,height: 20).foregroundColor(Color(.white))
                }
                .padding()
                .background(Color.green)
                .clipShape(Circle())
                .padding(30)
                .shadow(color: .gray.opacity(0.5), radius: 10)
            }
            .navigationTitle(Text("Lists"))
            .background(Color(UIColor.systemGroupedBackground))
        }
        .sheet(isPresented: $viewModel.showView) {
            if #available(iOS 15.0, *) {
                AddListView(viewModel: AddListViewModel())
            }
            else {
                AddListViewDepreciated(viewModel: AddListViewModel())
            }
        }
    }
    
    private func deleteButtonPress(offsets: IndexSet) {
        viewModel.onDeletePress(offsets: offsets)
        if viewModel.didDeleteList {
            contentViewModel.refreshView()
        }
    }
}

struct ListRow: View {
    var list: ListGL
    var body: some View {
        HStack {
            Text(list.title)
            Spacer()
        }
    }
}

struct HubView_Previews: PreviewProvider {
    static var previews: some View {
        HubView(user: User(username: "", fullname: "", email: "", uid: "", settings: ["greenListId": "", "redListId": ""]))
            .environmentObject(ContentViewModel())
    }
}
