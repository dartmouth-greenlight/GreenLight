//
//  HubView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI

struct HubView: View {
    @State private var editMode = EditMode.inactive
    @State var showView = false
    @EnvironmentObject var lists: Lists
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Color.green]
        navBarAppearance.titleTextAttributes = [.foregroundColor: Color.green]
        navBarAppearance.tintColor = .green
        
    }
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(lists.lists) { list in
                    NavigationLink {
                        ListView(title: list.name, names: list.list)
                    } label: {
                        ListRow(list: list)
                    }
                }
                .onDelete(perform: onDeletePress)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Lists")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: addButtonPress, trailing: EditButton())
        }
        .sheet(isPresented: $showView) {
            AddListView()
        }
    }
    
    private func onDeletePress(offsets: IndexSet) {
        lists.lists.remove(atOffsets: offsets)
    }
    
    private var addButtonPress: some View {
            switch editMode {
            case .inactive:
                return AnyView(Button(action: onAddPress) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
        }

    private func onAddPress() {
        showView.toggle()
    }
}

struct HubView_Previews: PreviewProvider {
    static var previews: some View {
        HubView()
    }
}
