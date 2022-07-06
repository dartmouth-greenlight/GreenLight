//
//  ContentView.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color(.white)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("GreenLight")
                        .font(.custom("Futura-Bold", size: 50))
                        .foregroundColor(.green)
                        .padding(.bottom,200)
                    VStack{
                        NavigationLink(
                            
                            destination: ScannerView(),
                            label: {
                                Text("Scanner")
                                    .frame(width: 240, height: 50)
                                    .background(Color.green)
                                    .font(.custom("Futura-Bold", size: 20))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(30)
                            })
                        NavigationLink(
                            
                            destination: ManualCheckView(),
                            label: {
                                Text("Manual Check")
                                    .frame(width: 240, height: 50)
                                    .background(Color.green)
                                    .font(.custom("Futura-Bold", size: 20))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(30)
                            })
                        NavigationLink(
                            
                            destination: HubView(),
                            label: {
                                Text("Lists")
                                    .frame(width: 240, height: 50)
                                    .background(Color.green)
                                    .font(.custom("Futura-Bold", size: 20))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(30)
                            })
                        }
                    }
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
