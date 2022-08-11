//
//  AddSearch.swift
//  GreenLight
//
//  Created by Jack Desmond on 7/7/22.
//

import SwiftUI

struct AddSearch: View {
    @ObservedObject var viewModel: AddSearchViewModel
    
    var body: some View {
        VStack {
            SearchBar(searchTerm: $viewModel.searchTerm)
                .padding()
            if viewModel.people.isEmpty {
                EmptySearch()
            } else {
                List(viewModel.people) { person in
                    SearchedPersonView(person: person)
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct SearchedPersonView: View {
    @ObservedObject var person: SearchPersonViewModel
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(person.name)
                Text(person.id)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
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
            Text("Search for a person...")
                .font(.title)
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

struct AddSearch_Previews: PreviewProvider {
    static var previews: some View {
        AddSearch(viewModel: AddSearchViewModel())
    }
}
