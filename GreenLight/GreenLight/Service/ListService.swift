//
//  ListService.swift
//  GreenLight
//
//  Created by Jack Desmond on 11/13/22.
//

import Firebase

struct ListService {
    
    func uploadList(title: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid":uid,
                    "title":title,
                    "timestamp":Timestamp(date: Date()),
                    "names":[String: String](),
                    "ids": [String]()] as [String : Any]
        
        Firestore.firestore().collection("lists").document()
            .setData(data) { error in
                if let error = error {
                    print("Creation of list failed with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
        
        
    }
    
    func deleteList(forList list: ListGL, completion: @escaping(Bool) -> Void) {
        Firestore.firestore().collection("lists")
            .document(list.id!)
            .delete { error in
                if let error = error {
                    print("Failed to delete list with error \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
        
    }
    
    func fetchLists(forUid uid: String, completion: @escaping([ListGL]) -> Void) {
        Firestore.firestore().collection("lists")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let lists = documents.compactMap({ try? $0.data(as: ListGL.self) })
            completion(lists.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
        }
    }
    
    func fetchList(forListId listId: String, completion: @escaping(ListGL) -> Void) {
        Firestore.firestore().collection("lists").document(listId).getDocument(){ snapshot, _ in
            guard let snapshot = snapshot else { return }
    
            guard let fetchedList = try? snapshot.data(as: ListGL.self) else { return }
            completion(fetchedList)
        }
    }
    
    func addToList(name: String, id: String, list: ListGL, completion: @escaping(Bool) -> Void) {
        var mapping = list.names
        mapping[id] = name
        let data = ["names": mapping,
                    "ids": FieldValue.arrayUnion([id])] as [String : Any]
        
        Firestore.firestore().collection("lists").document(list.id!)
            .updateData(data){ error in
                if let error = error {
                    print("Add to list failed with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
    }
    
    func removeFromList(forList list: ListGL, id: String, completion: @escaping(Bool) -> Void) {
        let data = ["names.\(id)": FieldValue.delete(),
                    "ids": FieldValue.arrayRemove([id])] as [String : Any]
        
        Firestore.firestore().collection("lists").document(list.id!)
            .updateData(data){ error in
                if let error = error {
                    print("Add to list failed with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
        
    }
}
