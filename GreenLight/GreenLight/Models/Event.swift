//
//  Event.swift
//  GreenLight
//
//  Created by Jack Desmond on 12/10/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Event: Identifiable, Decodable {
    @DocumentID var id: String?
    let uid: String
    let title: String
    let attendees: [Attendee]
    let timestamp: Timestamp
}
