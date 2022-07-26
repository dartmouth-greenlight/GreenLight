//
//  GreenLightList.swift
//  GreenLight
//
//  Created by Jack Desmond on 7/15/22.
//

import Foundation
import SwiftUI

struct GreenLightList: Identifiable {
    let id = NSDate().timeIntervalSince1970
    var name: String
    var list: Array<Person>
}
