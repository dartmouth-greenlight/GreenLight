//
//  HubView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI

struct HubView: View {
    @State private var lists: [GreenLightList] =
    [GreenLightList(name: "Social List", list: socialList),
    GreenLightList(name: "Black List", list: blackList),
    GreenLightList(name: "KKG", list: blackList)]
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(lists) { list in
                    NavigationLink {
                        
                    } label: {
                        ListRow(list: list)
                    }
                }
            }
            .navigationTitle("Lists")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct HubView_Previews: PreviewProvider {
    static var previews: some View {
        HubView()
    }
}
