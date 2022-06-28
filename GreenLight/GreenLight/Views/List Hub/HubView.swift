//
//  HubView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI

struct HubView: View {
    var body: some View {
            ZStack{
                Color(.white)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                    Text("Your Lists")
                        .font(.custom("Futura-Bold", size: 30))
                        .foregroundColor(.green)
                        .padding(.bottom,20)
                    VStack{
                        NavigationLink(
                            
                            destination: ListView(title: "Social List", names: socialList),
                            label: {
                                Text("Social List")
                                    .frame(width: 240, height: 50)
                                    .background(Color.green)
                                    .font(.custom("Futura-Bold", size: 20))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(30)
                                    .padding(15)
                            })
                        NavigationLink(
                            
                            destination: ListView(title: "Black List", names: blackList),
                            label: {
                                Text("Black List")
                                    .frame(width: 240, height: 50)
                                    .background(Color.green)
                                    .font(.custom("Futura-Bold", size: 20))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(30)
                    })
                }
            Spacer()
            Spacer()
            }
        }
    }
}

struct HubView_Previews: PreviewProvider {
    static var previews: some View {
        HubView()
    }
}
