//
//  ManualCheckViewModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/9/22.
//

import Foundation
import SwiftUI

class ManualCheckViewModel: ObservableObject{
    @Environment(\.colorScheme) var colorScheme
    
    @Published var color = 0
    @Published var reset = false
    @Published var bannerTitle = "Manual Check"
    @Published var id = ""
    
    var backgroundColor: Color{
        if(color == 0)
        {
            if (colorScheme == .light) {
                return Color(UIColor.secondarySystemBackground);
            }
            else {
                return Color(.black)
            }
        }
        else if (color == 1)
        {
            return Color.green;
        }
        else if (color == 2)
        {
            return Color.red;

        }
        else
        {
            return Color.yellow
        }
    }
        
    func checkID (stuID: String) {
        if(stuID != ""){
            reset = true
            if (socialDict.keys.contains(stuID.uppercased())) {
                bannerTitle = socialDict[stuID.uppercased()]!
                color = 1
            }
            else if (blackDict.keys.contains(stuID.uppercased())){
                bannerTitle = blackDict[stuID.uppercased()]!
                color = 2
            }
            else {
                bannerTitle = getName(id: stuID)
                color = 3
            }
        }
    }
    
    func resetVars(){
        color = 0
        reset = false
        id = ""
        bannerTitle = "Manual Check"
    }
}
