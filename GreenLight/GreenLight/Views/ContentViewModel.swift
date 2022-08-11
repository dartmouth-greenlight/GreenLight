//
//  ContentViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/9/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var lists:[GreenLightList] =  [GreenLightList(name: "Social List", list: socialList),
                                              GreenLightList(name: "Black List", list: blackList),
                                              GreenLightList(name: "Beta", list: beta)]
    @Published var onManualCheckView = false
}
