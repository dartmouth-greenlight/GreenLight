//
//  UserService.swift
//  GreenLight
//
//  Created by Jack Desmond on 11/13/22.
//

import Firebase

struct UserService {
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument(){ snapshot, _ in
                guard let snapshot = snapshot else { return }
        
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                completion(user)
            }
    }
    
    func updateSettings(forUid uid: String, greenListId: String, redListId: String, completion: @escaping(Bool) -> Void) {
        let data = ["settings": ["greenListId": greenListId, "redListId": redListId]] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid)
            .updateData(data){ error in
                if let error = error {
                    print("Update to user settings failed with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
}
