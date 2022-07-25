//
//  Names.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//  Authored by Tucker Simpson and Jack Desmond
//

import Foundation
import SwiftUI

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
[Person(name: "Tucker Simpson", id: "F004H39", year: "24")]
let socialList =
[Person(name:"Jackson Desmond" , id: "F004HBW", year: "24")]
let beta = [Person(name:"Jackson Desmond" , id: "F004HBW", year: "24"), Person(name:"Henry Exall" , id: "F004DPR", year: "24")]


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
           "F004P7P" : "Lynne Li",
           "F004N7C" : "Marissa O. Onwuka"
            ]


let APhi = ["F0044T8" : "Eden Schneck",
            "F004G9H" : "Harley Kell",
            "F004MR8" : "Emily Osman",
            "F004H5D" : "Madison Blanche",
            "F004GS4" : "Grace Cason",
            "F004H6H" : "Kira Fontaine",
            "F004Q2G" : "Amy Morrissey",
            "F004GZT" : "Emily Levonas",
            "F004PG4" : "Stephanie Lee",
            "F004PSV" : "Advaita S. Chaudhari",
            "F004GF7" : "Lillian Leimkuhler",
            "F004GD7" : "Payton Altman",
            "F004GFV" : "Katherine G. Weber",
            "F004N4G" : "Isa Robinson",
            "F004R1M" : "Lauren Liu",
            "F004MQC" : "Marguerite Morgan",
            "F004XMS" : "Sídney Marsh",
            "F004RJ0" : "Gabriela Marquez Cortez",
            "F004NWG" : "Neha Agarwal",
            "F004NVQ" : "Lauren Lee",
            "F004H61" : "Isabelle Dady",
            "F004Y2W" : "Caroline Kramer",
            "F004XDT" : "Ellie Boyd",
            "F004N61" : "Marisa Joseph",
            "F004GZ0" : "Lily Ding",
            "F004P82" : "Margaret Bone",
            "F004GXG" : "Alexa Lomonaco",
            "F004P88" : "Carolina Stedman",
            "F004MSF" : "Chloe Taylor",
            "F004NQT" : "Cassidy Wechter",
            "F004MQV" : "Emma Merlini",
            "F004GCF" : "Madeline A. Hawkins",
            "F004GG5" : "Gracie Dickman",
            "F0042MG" : "Ella Gates",
            "F004H9X" : "Solenne Wolfe",
            "F004P8B" : "Nicole Tooper",
            "F0042MJ" : "Paulina Marinkovic",
            "F004GPJ" : "Isabella Fox",
            "F004GBT" : "Carrington Washburn",
            "F004H8N" : "Cecilia A. Rafter",
            "F004MSN" : "Adriana Chavira-Ochoa",
            "F004PPD" : "Grace Gallant",
            "F004GG7" : "Lily Scott",
            "F004GQY" : "Daisy Granholm",
            "F004PFP" : "Lilian C. Hemmins"
        ]



let demoDict = ["F004HBW" : "Jackson Desmond",
                "F004H1H" : "Katherine L. Levy",
                "F004GZY" : "Daniel J. Locascio",
                "F004Y2W" : "Caroline B. Kramer",
                "F004Q8X" : "Isabelle B. Lewitt"
                ]

let demoBlackList = ["F004H39" : "Tucker Simpson"]

let socialDict = demoDict

let blackDict = demoBlackList

