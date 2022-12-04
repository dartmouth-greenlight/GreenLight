//
//  ListView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import Firebase

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    init(list: ListGL) {
        self.viewModel = ListViewModel(list: list)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                List() {
                    ForEach(viewModel.ids, id: \.self) { id in
                     VStack(alignment: .leading, spacing: 5){
                         Text(viewModel.list.names[id]!)
                     .fontWeight(.semibold)
                     Text(id)
                     .font(.subheadline)
                     }
                     }
                     .onDelete(perform: viewModel.onDeletePress)
                }
                .navigationTitle(viewModel.list.title)
                .navigationBarTitleDisplayMode(.large)
                .navigationBarBackButtonHidden(viewModel.isEditing)
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
        .background(Color(UIColor.systemGroupedBackground))
        .sheet(isPresented: $viewModel.showView, onDismiss: {
            viewModel.fetchUpdatedList()
        }) {
            AddSearch(viewModel: AddSearchViewModel(), listViewModel: viewModel)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(list: ListGL(uid: "", title: "", timestamp: Timestamp(date: Date()), names: ["f004hbw":"Jack Desmond"], ids: ["f004hbw"]))
    }
}
