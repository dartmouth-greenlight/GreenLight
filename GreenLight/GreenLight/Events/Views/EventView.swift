//
//  EventView.swift
//  GreenLight
//
//  Created by Jack Desmond on 12/25/22.
//

import SwiftUI
import Firebase

struct EventView: View {
    @ObservedObject var viewModel: EventViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    init(event: Event) {
        self.viewModel = EventViewModel(event: event)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                List() {
                    Section {
                        ForEach(viewModel.event.attendees, id: \.self) { attendee in
                            AttendeeRow(attendee: attendee)
                        }
                    } header: {
                        Text("Attendees")
                    }
                }
                .navigationTitle(viewModel.event.title)
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct AttendeeRow: View {
    var attendee: Attendee
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(attendee.name)
                    .fontWeight(.semibold)
                Spacer()
                Text(attendee.year)
                    .font(.subheadline)
            }
            Text(attendee.timestamp.dateValue(), style: .time)
                .font(.subheadline)
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(uid: "", title: "", attendees: [Attendee(name: "", year: "", studentId: "", timestamp: Timestamp())], timestamp: Timestamp()))
    }
}
