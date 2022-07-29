//
//  Lists.swift
//  GreenLight
//
//  Created by Jack Desmond on 7/17/22.
//

import Foundation

class Lists: ObservableObject {
    @Published var lists:[GreenLightList] =  [GreenLightList(name: "Social List", list: socialList),
                                              GreenLightList(name: "Black List", list: blackList),
                                              GreenLightList(name: "Beta", list: beta)]
}
