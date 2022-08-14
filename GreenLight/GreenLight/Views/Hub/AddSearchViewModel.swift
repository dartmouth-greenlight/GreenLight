//
//  SearchViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/6/22.
//

import Foundation
import Combine
import SwiftUI

class AddSearchViewModel: ObservableObject {
    private var list: GreenLightList
    
    @Published var searchTerm = ""
    @Published public private(set) var people: [SearchPersonViewModel] = []
    
    private let dataModel: SearchDataModel = SearchDataModel()
    private var disposables =  Set<AnyCancellable>()
    
    private func loadUsers(searchTerm: String) {
        people.removeAll()
        dataModel.loadUsers(searchTerm: searchTerm) { people in
            people.forEach { self.appendUser(user: $0) }
        }
    }
    
    private func appendUser(user: User) {
        DispatchQueue.main.async {
            if(user.uid.prefix(3)=="f00") {
                if(user.mail !=  nil){
                    
                    // Get class year from email
                    let yearPieces = user.mail!.split(separator: "@")
                    let twoDigYear = yearPieces[0].split(separator: ".")
                    var currYear = ""
                    currYear += twoDigYear.last!
                    
                    //toggle this to include / exclude grad students/older alums
                    if(currYear.prefix(1) == "2"){
                        if(currYear.prefix(2) == "22" || currYear.prefix(2) == "23" || currYear.prefix(2) == "24" || currYear.prefix(2) == "25" || currYear.prefix(2) == "26") {
                            let curr = SearchPersonViewModel(name: user.displayName, id: user.uid, year: currYear, list: self.list)
                            self.people.append(curr)
                        }
                    }
                }
            }
        }
    }
    init(list: GreenLightList) {
        self.list = list
        $searchTerm
            .sink(receiveValue: loadUsers(searchTerm:))
            .store(in: &disposables)
    }
}

class SearchPersonViewModel: Identifiable, ObservableObject {
    let id: String
    let name: String
    let year: String
    let list: GreenLightList
    @Published var added: Bool
    @Published var icon: String
    
    init(name: String, id: String, year: String, list: GreenLightList) {
        self.id = id.uppercased()
        self.name = name
        self.year = year
        self.list = list
        self.added = list.contains(uid: id) //false if they are not on the list
        self.icon = "plus.circle.fill"
        if(self.added){
            self.icon = "checkmark.circle.fill" //true, meaning they are on the list
        }else{
            self.icon = "plus.circle.fill"
        }
    }
    
    
    func addToList(list: GreenLightList, person: SearchPersonViewModel, contentViewModel: ContentViewModel) {
        self.icon = "checkmark.circle.fill"
        contentViewModel.addToList(list: list, person: Person(name: person.name, id: person.id, year: person.year))
    }
}
