//
//  AddSearch.swift
//  GreenLight
//
//  Created by Jack Desmond on 7/7/22.
//

import SwiftUI

struct AddSearch: View {
    @ObservedObject var viewModel: AddSearchViewModel
    @ObservedObject var listViewModel: ListViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack {
            SearchBar(searchTerm: $viewModel.searchTerm)
                .padding()
            if viewModel.people.isEmpty {
                EmptySearch()
            } else {
                List(viewModel.people) { person in
                    SearchedPersonView(person: person, listViewModel: listViewModel)
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct SearchedPersonView: View {
    @ObservedObject var person: SearchPersonViewModel
    @ObservedObject var listViewModel: ListViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(person.name)
                Text(person.id)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                person.addToList(name: person.name, id: person.id, list: listViewModel.list)
                if(!person.added){
                    person.icon = "checkmark.circle.fill"
                }
            }, label: {
                Image(systemName:person.icon).resizable().frame(width: 20, height: 20).foregroundColor(.green)
            })
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
    }
}

struct EmptySearch: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.badge.plus")
                .font(.system(size: 90))
                .padding(.bottom)
                .foregroundColor(.green)
            Text("Search for a person...")
                .font(.title)
                .foregroundColor(.green)
            Spacer()
        }
    }
}

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    @Binding var searchTerm: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Type a person's name"
        return searchBar
    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchTerm: $searchTerm)
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchTerm: String
        
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}
