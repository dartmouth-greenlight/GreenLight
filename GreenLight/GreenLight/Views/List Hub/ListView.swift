//
//  ListView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI

struct ListView: View {
    var title: String
    var names: [Name]
    
    init(title: String, names: [Name]) {
        self.title = title
        self.names = names
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some View {
        ZStack{
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text(self.title)
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                List(names, id: \.name){ name in
                    VStack(alignment: .leading, spacing: 5){
                        Text(name.name)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text(name.id)
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .listRowBackground(Color.white)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Black List", names: blackList)
    }
}
