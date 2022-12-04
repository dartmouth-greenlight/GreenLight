//
//  List.swift
//  GreenLight
//
//  Created by Jack Desmond on 11/17/22.
//

import FirebaseFirestoreSwift
import Firebase

struct ListGL: Identifiable, Decodable {
    @DocumentID var id: String?
    let uid: String
    let title: String
    let timestamp: Timestamp
    let names: [String:String]
    let ids: [String]
}
