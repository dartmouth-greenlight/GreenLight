//
//  EventsView.swift
//  GreenLight
//
//  Created by Jack Desmond on 12/11/22.
//

import SwiftUI

struct EventsView: View {
    @ObservedObject var viewModel: EventsViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    init(user: User) {
        self.viewModel = EventsViewModel(user: user)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    List() {
                        ForEach(viewModel.events) { event in
                            NavigationLink {
                                EventView(event: event)
                            } label: {
                                EventRow(event: event)
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
            .navigationTitle(Text("Events"))
            .background(Color(UIColor.systemGroupedBackground))
        }
        .sheet(isPresented: $viewModel.showView) {
            if #available(iOS 15.0, *) {
                AddEventView(viewModel: AddEventViewModel())
            }
            else {
                AddEventViewDepreciated(viewModel: AddEventViewModel())
            }
        }
    }
    
    private func deleteButtonPress(offsets: IndexSet) {
        viewModel.onDeletePress(offsets: offsets)
        if viewModel.didDeleteEvent {
            contentViewModel.refreshView()
        }
    }
}

struct EventRow: View {
    var event: Event
    var body: some View {
        HStack {
            Text(event.title)
            Spacer()
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(user: User(username: "", fullname: "", email: "", uid: "", settings: ["greenListId": "", "redListId": ""]))
            .environmentObject(ContentViewModel())
    }
}
