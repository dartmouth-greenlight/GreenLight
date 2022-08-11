//
//  ListView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    
    init(title: String, names: [Person]) {
        self.viewModel = ListViewModel(title: title, names: names)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.green]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.green]
        
    }
    var body: some View {
        List() {
            ForEach(viewModel.names, id: \.name) { name in
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
        .navigationBarItems(trailing: EditButton())
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Black List", names: blackList)
    }
}
