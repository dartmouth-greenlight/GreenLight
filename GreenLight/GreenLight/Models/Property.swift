//
//  Properties.swift
//  GreenLight
//
//  Created by Tucker Simpson on 7/22/22.
//

import Foundation

public class Property {
    public var flashOn:Bool = false
    public var flashInScanner:Bool = false
    public var foundString: Bool = false
    public var yellow: Bool = false

    static let sharedInstance = Property()
}
