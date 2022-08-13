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
    
    init() {
        self.viewModel = HubViewModel()
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.green]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.green]
        navBarAppearance.tintColor = .green
        
    }
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(contentViewModel.lists) { list in
                    NavigationLink {
                        ListView(list: list)
                    } label: {
                        ListRow(list: list)
                    }
                }
                .onDelete(perform: deleteButtonPress)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Lists")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !viewModel.isEditing {
                        Button(action: viewModel.onAddPress) { Image(systemName: "plus") }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.isEditing.toggle()
                    }) {
                        if viewModel.isEditing {
                            Text("Done")
                        } else {
                            Text("Edit")
                        }
                    }
                }
            }
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
        viewModel.onDeletePress(offsets: offsets, viewModel: contentViewModel)
    }
}

struct ListRow: View {
    var list: GreenLightList
    var body: some View {
        HStack {
            Text(list.name)
            Spacer()
        }
    }
}

struct HubView_Previews: PreviewProvider {
    static var previews: some View {
        HubView()
            .environmentObject(ContentViewModel())
    }
}
