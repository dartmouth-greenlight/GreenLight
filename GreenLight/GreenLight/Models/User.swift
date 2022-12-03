//
//  User.swift
//  GreenLight
//
//  Created by Jack Desmond on 11/13/22.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
    let uid: String
    let settings: [String:String]
}
