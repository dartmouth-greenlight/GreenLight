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
                        ListView(title: list.name, names: list.list)
                    } label: {
                        ListRow(list: list)
                    }
                }
                .onDelete(perform: deleteButtonPress)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Lists")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: addButtonPress, trailing: EditButton())
        }
        .sheet(isPresented: $viewModel.showView) {
            AddSearch(viewModel: AddSearchViewModel())
        }
    }
    
    private func deleteButtonPress(offsets: IndexSet) {
        viewModel.onDeletePress(offsets: offsets, viewModel: contentViewModel)
    }
    
    private var addButtonPress: some View {
        switch viewModel.editMode {
            case .inactive:
            return AnyView(Button(action: viewModel.onAddPress) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
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
