//
//  ContentViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/9/22.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ContentViewModel: ObservableObject {
    
    let auth = Auth.auth()
    @Published var loggedIn = false
    @Published var userID = ""

    var isLoggedIn: Bool {
        return auth.currentUser != nil
    }
    
    var listNames = ["Social List":1, "Black List":1]
    @Published var lists:[GreenLightList] =  [GreenLightList(name: "Social List", list: socialList, dict: socialDict),
                                              GreenLightList(name: "Black List", list: blackList, dict: demoBlackList)]
    
    @Published var onManualCheckView = false
    
    
    func addToList(list: GreenLightList, person: Person) {
        if let index = self.lists.firstIndex(where: { $0.id == list.id }) {
            print(lists[index].name)
            if(lists[index].dict[person.id] == nil){
                lists[index].dict[person.id] = person.name
                lists[index].list.append(person)
            }else{
                print("name already added")
            }
        }
    }
    
    func addList(name: String){
        if(listNames[name] == 1){
            //TODO: notify user that this happened
            print("list name not available")
        }else{
            listNames[name] = 1
            lists.append(GreenLightList(name: name, list: [], dict: [String:String]()))
        }
    }
    
    
    
    // MARK: Log-In and Firebase stuff
    func logIn(username: String, pword: String){
        auth.signIn(withEmail: username, password: pword){ [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //Success
            DispatchQueue.main.async {
                self?.loggedIn = true
                self?.userID = result!.user.uid
            }
            
        }
    }
    
    func signUp(username: String, pword: String, org: String){
        let user = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = pword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        auth.createUser(withEmail: user, password: password){ [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            
            //Success
            let db = Firestore.firestore()
           

            db.collection("Users").document(result!.user.uid).setData(["Organization":org]){(error) in
                if error != nil{
                    return
                }
            }
            
            DispatchQueue.main.async {
                self?.loggedIn = true
                self?.userID = result!.user.uid
            }
        }
        
    }
    
    func signOut(){
        try? auth.signOut()
        self.loggedIn = false
        self.userID = ""
    }
    
}
