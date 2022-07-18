//
//  Lists.swift
//  GreenLight
//
//  Created by Jack Desmond on 7/17/22.
//

import Foundation

var blackList = [Person]()
var socialList = [Person]()
var kkgList = [Person]()


let lists =
[GreenLightList(name: "Social List", list: socialList),
 GreenLightList(name: "Black List", list: blackList),
 GreenLightList(name: "KKG", list: kkgList)]
