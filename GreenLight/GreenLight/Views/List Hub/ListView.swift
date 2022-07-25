//
//  ListView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI

struct ListView: View {
    @State private var editMode = EditMode.inactive
    @State var names: [Person]
    var title: String
    
    init(title: String, names: [Person]) {
        self.title = title
        _names = State<[Person]>(initialValue: names)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.green]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.green]
        
    }
    var body: some View {
        List() {
            ForEach(names, id: \.name) { name in
                VStack(alignment: .leading, spacing: 5){
                    Text(name.name)
                        .fontWeight(.semibold)
                    Text(name.id)
                        .font(.subheadline)
                }
            }
            .onDelete(perform: onDeletePress)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarItems(trailing: EditButton())
    }
    private func onDeletePress(offsets: IndexSet) {
        names.remove(atOffsets: offsets)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Black List", names: blackList)
    }
}
