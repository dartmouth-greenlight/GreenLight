//
//  ListRow.swift
//  GreenLight
//
//  Created by Jack Desmond on 7/15/22.
//

import SwiftUI

struct ListRow: View {
    var list: GreenLightList
    var body: some View {
        HStack {
            Text(list.name)
            Spacer()
        }
    }
}
