//
//  Attendee.swift
//  GreenLight
//
//  Created by Jack Desmond on 12/10/22.
//


import FirebaseFirestoreSwift
import Firebase

struct Attendee: Decodable, Encodable, Hashable {
    let name: String
    let year: String
    let studentId: String
    let timestamp: Timestamp
}

