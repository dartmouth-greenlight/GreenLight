//
//  Names.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//

import Foundation
import SwiftUI
import OrderedCollections

struct Name{
    var name: String
    var id: String
}

let blackList =
    [Name(name: "Tucker Simpson", id: "F004H39")]
let socialList =
    [Name(name:"Jackson Desmond" , id: "F004HBW")]

let blackDict = OrderedDictionary(uniqueKeys: ["F004H39"], values: ["Tucker C. Simpson"])
let socialDict = OrderedDictionary(uniqueKeys: ["F004HBW", "F004H1H", "F004GZY", "F004Y2W", "F004Q8X"], values: ["Jackson Desmond", "Katherine L. Levy", "Daniel J. Locascio", "Caroline B. Kramer", "Isabelle B. Lewitt"])

