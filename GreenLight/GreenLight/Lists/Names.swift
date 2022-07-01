//
//  Names.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//  Authored by Tucker Simpson and Jack Desmond
//

import Foundation
import SwiftUI
import OrderedCollections

struct Name{
    var name: String
    var id: String
}

class ListOfNames : Equatable {
    var listDict = [String: String]()
    var listName : String
    
    init(dict: [String: String], listName1: String){
        listDict = dict
        listName = listName1
    }
    
    init(listName1: String){
        listName = listName1
    }
        
    func addID(uid: String) {
        let uName = getName(id: uid)
        listDict[uid] = uName
    }
    
    func get(uid: String) -> String{
        return listDict[uid] ?? "No name found."
    }
    
    func remove(uid: String){
        listDict.removeValue(forKey: uid)
    }
    
    func contains(uid: String) -> Bool{
        if(listDict[uid] != nil){
            return true
        }
        return false
    }
    
    public static func ==(lhs: ListOfNames, rhs: ListOfNames) -> Bool{
        return lhs.listName == rhs.listName
    }
    
}

//struct InviteList {
//    //var listList = [ListOfNames()]
//
//    init(listOfLists: [ListOfNames]){
//        listList = listOfLists
//    }
//
//    func removeList(rem: ListOfNames){
//        let index = listList.firstIndex(of: rem)
//        if(index != nil){
//            //listList.remove(at: index!)
//        }
//    }
//}



let blackList =
    [Name(name: "Tucker Simpson", id: "F004H39")]
let socialList =
    [Name(name:"Jackson Desmond" , id: "F004HBW")]

let kkg = ["F004GG9" : "Abbey Savin",
           "F004H7F" : "Agatha la Voie ",
           "F004PKY" : "Alina Chadwick ",
           "F004PPP" : "Anna K. Ray",
           "F004GM4" : "Annabel Gerber",
           "F004HCV" : "Annie Qiu",
           "F004R1P" : "Aurelie J. Temsamani",
           "F004GC5" : "Bella Godsick",
           "F004R11" : "Isabella Huschitt",
           "F004Q8X" : "Isabelle Lewitt",
           "F004H0D" : "Caroline Oyster",
           "F004Y2Y" : "Catherine Grimes",
           "F0043VQ" : "Celeste Ulicki",
           "F004P8M" : "Crystal Igwe",
           "F004H75" : "Elda Kahssay",
           "F0046QZ" : "Eliza Durbin",
           "F004R8D" : "Elizabeth Frey",
           "F004GCK" : "Eleanor Burke",
           "F004XPQ" : "Emily Gao",
           "F004GZ6" : "Grace Farr",
           "F004GDM" : "Grace Mensi",
           "F004GNM" : "Halle Troadec",
           "F004HCZ" : "Hannah Sheehy",
           "F004GZD" : "Isabella Hamlen",
           "F004GJ3" : "Julia Gottschalk",
           "F004YFD" : "Julia Lee",
           "F004GC7" : "Katherine Sung",
           "F004GX5" : "Kelly Beaupre",
           "F004MQ1" : "Kristabel Konta",
           "F004P5V" : "Lauren Hwang",
           "F004H3Q" : "Liana M. Laremont",
           "F004GHF" : "Margaux Van Allen",
           "F004GTX" : "Margot Luria",
           "F004GDR" : "Megan Lynch",
           "F004H08" : "Mia McClure",
           "F005R2R" : "Molly Rouzie",
           "F004R95" : "Rebecca Liu",
           "F004GTZ" : "Rosemary McCarthy",
           "F004GPM" : "Rujuta Pandit",
           "F004MSK" : "Sydney Rosenbaum",
           "F004N5H" : "Victoria Smith",
           "F004GY6" : "Valentina Fernandez",
           "F004GQG" : "Willa Shannon",
           "F004NKK" : "Yumi Yoshiyasu",
           "F004MPX" : "Zoe Moon",
           "F004RXV" : "Anne Burton",
           "F004GKM" : "Cam Calcano",
           "F004P7P" : "Lynne Li"
            ]

let kkgDict = ListOfNames(dict: kkg, listName1: "KKG")

let blackDict = OrderedDictionary(uniqueKeys: ["F004H39"], values: ["Tucker C. Simpson"])
let socialDict = OrderedDictionary(uniqueKeys: ["F004HBW", "F004H1H", "F004GZY", "F004Y2W", "F004Q8X"], values: ["Jackson Desmond", "Katherine L. Levy", "Daniel J. Locascio", "Caroline B. Kramer", "Isabelle B. Lewitt"])
