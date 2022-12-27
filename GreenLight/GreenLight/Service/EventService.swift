//
//  EventService.swift
//  GreenLight
//
//  Created by Jack Desmond on 12/11/22.
//

import Firebase

struct EventService {
    
    func uploadEvent(title: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid":uid,
                    "title":title,
                    "timestamp":Timestamp(date: Date()),
                    "attendees":[Attendee]()] as [String : Any]
        
        Firestore.firestore().collection("events").document()
            .setData(data) { error in
                if let error = error {
                    print("Event creation failed with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
        
        
    }
    
    func deleteEvent(forEvent event: Event, completion: @escaping(Bool) -> Void) {
        Firestore.firestore().collection("events")
            .document(event.id!)
            .delete { error in
                if let error = error {
                    print("Failed to delete event with error \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
        
    }
    
    func fetchEvents(forUid uid: String, completion: @escaping([Event]) -> Void) {
        Firestore.firestore().collection("events")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let events = documents.compactMap({ try? $0.data(as: Event.self) })
            completion(events.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
        }
    }
    
    func fetchEvent(forEventId eventId: String, completion: @escaping(Event) -> Void) {
        Firestore.firestore().collection("events").document(eventId).getDocument(){ snapshot, _ in
            guard let snapshot = snapshot else { return }
    
            guard let fetchedEvent = try? snapshot.data(as: Event.self) else { return }
            completion(fetchedEvent)
        }
    }
    
    func addAttendee(name: String, studentId: String, year: String, eventId: String, completion: @escaping(Bool) -> Void) {
        let student = try? Firestore.Encoder().encode(Attendee(name: name, year: year, studentId: studentId, timestamp: Timestamp(date: Date())))
        let data = ["attendees": FieldValue.arrayUnion([student as Any])] as [String : Any]
        
        Firestore.firestore().collection("events").document(eventId)
            .updateData(data){ error in
                if let error = error {
                    print("Add to event attendees failed with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
    }
}
