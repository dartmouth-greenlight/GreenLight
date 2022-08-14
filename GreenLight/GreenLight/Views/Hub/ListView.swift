//
//  ListView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    init(list: GreenLightList) {
        self.viewModel = ListViewModel(list: list)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.green]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.green]
        
    }
    var body: some View {
        List() {
            ForEach(viewModel.list.list, id: \.name) { name in
                VStack(alignment: .leading, spacing: 5){
                    Text(name.name)
                        .fontWeight(.semibold)
                    Text(name.id)
                        .font(.subheadline)
                }
            }
            .onDelete(perform: viewModel.onDeletePress)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(viewModel.isEditing)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if viewModel.isEditing {
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
        .sheet(isPresented: $viewModel.showView) {
            AddSearch(viewModel: AddSearchViewModel(list: viewModel.list), listViewModel: viewModel)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(list: GreenLightList(name: "blacklist", list: blackList, dict: demoBlackList))
    }
}
