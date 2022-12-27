//
//  EventsViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 12/11/22.
//

import Foundation
import SwiftUI

class EventsViewModel: ObservableObject {
    @Published var events = [Event]()
    @Published var showView = false
    @Published var didDeleteEvent = false
    let user: User
    let service = EventService()
    
    
    init(user: User) {
        self.user = user
        self.fetchUserLists()
    }
    
    func fetchUserLists() {
        guard let uid = user.id else { return }
        service.fetchEvents(forUid: uid) { events in
            self.events = events
        }
    }
    
    func onDeletePress(offsets: IndexSet) {
        offsets.forEach { index in
            let event = self.events[index]
            service.deleteEvent(forEvent: event) { success in
                if success {
                    self.didDeleteEvent = true
                }
            }
            
        }
        events.remove(atOffsets: offsets)
    }

    func onAddPress() {
        showView.toggle()
    }
}
