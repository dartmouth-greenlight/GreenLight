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
           "F004P7P" : "Lynne Li",
           "F004N7C" : "Marissa O. Onwuka"
            ]

let socialDict = ["F003XS5" : "Steven Mendley",
                  "F004R9B" : "Henry Exall",
                  "F004HBW" : "Jack Desmond",
                  "F004Y59" : "Sam Winchester",
                  "F004H7C" : "Andrew Koulogeorge",
                  "F004YBZ" : "Tucker Jones",
                  "F004G8S" : "Cade Keesling",
                  "F004MPX" : "Zoe Moon",
                  "F004MR6" : "Rachel Zhang",
                  "F004GZD" : "Isabella Z. Hamlen",
                  "F004QC4" : "Karim M. Khalil",
                  "F004MTV" : "Zach Brown",
                  "F004N5B" : "Federico Goudie",
                  "F004GC5" : "Bella Godsick",
                  "F004GKM" : "Cam Calcano",
                  "F004GDR" : "Megan Lynch",
                  "F004GJ1" : "Kimberley S. Ekern,",
                  "F004MSH" : "Priya Verma",
                  "F004R1P" : "Aurelie Temsamani",
                  "F004Q8S" : "Tejas J. Parekh",
                  "F004QX5" : "Charles W. Vaules",
                  "F004PKY" : "Alina Chadwick",
                  "F004GDM" : "Grace Mensi",
                  "F004Q8X" : "Isabelle B. Lewitt",
                  "F004GDY" : "Diana Bates",
                  "F004GB5" : "Ellie Blain",
                  "F004N3W" : "Chloe Park",
                  "F004GC3" : "Camryn Foltz",
                  "F004GBT" : "Carrington Washburn",
                  "F004H6S" : "Natalie Grover",
                  "F004H9M" : "Nicholas D. Unruh",
                  "F003XVH" : "Joseph M. Musa",
                  "F004GX7" : "Tyler Borsch",
                  "F004N7Z" : "Addi Textor",
                  "F004GZ2" : "Jack Dyett",
                  "F004MQ3" : "Marquist Allen",
                  "F004GBW" : "Gannon Mccorkle",
                  "F004GM4" : "Annabel Gerber",
                  "F004XN1" : "India Tehranchi",
                  "F004GH3" : "Julia Mastrio",
                  "F004GDG" : "Reed Cole",
                  "F004GGN" : "Tamer Luzi",
                  "F004GFK" : "Sophia Franco",
                  "F004GTZ" : "Rosemary K. Mccarthy",
                  "F004GYB" : "Ryan Lovett",
                  "F004GYD" : "Josh 'Perpetual Sad Peter' Waters",
                  "F004H95" : "Ryan Sorkin",
                  "F004MRT" : "Tevita Moimoi",
                  "F004GB3" : "Nic Sani",
                  "F004MPG" : "Jarmone Sutherland",
                  "F004G9C" : "Karen Murphy",
                  "F004HD1" : "Taylor Williams",
                  "F004GF2" : "Grace Faulkner",
                  "F0041J8" : "Julia Levine",
                  "F004GQG" : "Willa Shannon",
                  "F004N73" : "John M. Gnibus",
                  "F004MT5" : "Adin Mcauliffe",
                  "F004Y3B" : "Sam O'Donnell",
                  "F004GG7" : "Lily Scott",
                  "F004XMS" : "Sidney Marsh",
                  "F004MSN" : "Adri Chavira",
                  "F004MQC" : "Marguerite Morgan",
                  "F004H1J" : "Elizabeth Ding",
                  "F004GY6" : "Valentina Fernandez",
                  "F004HC6" : "Elliot Kim",
                  "F003WPW" : "Oscar Lee",
                  "F004H2X" : "Max Weinstein",
                  "F004R1M" : "Lauren Liu",
                  "F004H0D" : "Caroline Oyster",
                  "F004H08" : "Mia Mcclure",
                  "F004YBV" : "David Lim",
                  "F004GR0" : "Anna M. Nolan",
                  "F004GM2" : "Avery Fogg",
                  "F004MVN" : "Luke House",
                  "F004R8D" : "Elizabeth Frey",
                  "F004H5S" : "Jihwan Choi",
                  "F004PKM" : "Thomas Policicchio",
                  "F004H1Z" : "Alan Moss",
                  "F004H8H" : "Josh Pfefferkorn",
                  "F004NKZ" : "Jeff Liu",
                  "F004NVQ" : "Lauren Lee",
                  "F004XPQ" : "Emily Gao",
                  "F004Y38" : "Claire Macedonia",
                  "F004N4G" : "Isa Robinson",
                  "F004GD7" : "Payton Altman",
                  "F004NKH" : "Eleanor Schifino",
                  "F004HCZ" : "Hannah Sheehy",
                  "F004H3Q" : "Liana Laremont",
                  "F004PG4" : "Stephanie Lee",
                  "F004GJ9" : "Rem Katyal",
                  "F004H04" : "Rob Mailley",
                  "F004H00" : "Armon Lotfi",
                  "F004N58" : "Sam Williams",
                  "F004Q2G" : "Amy Morrissey",
                  "F004H5D" : "Madison Blanche",
                  "F004QMY" : "Logan Chang",
                  "F004PT5" : "Renesa Khanna",
                  "F004GY2" : "Ethan Tam",
                  "F004G9H" : "Harley Kell",
                  "F00449T" : "Esme Lee",
                  "JAWN" : "Jabroni Smith",
                  "F004NQT" : "Cassidy Wechter",
                  "F004GFV" : "Katherine G. Weber",
                  "F004GTN" : "Rachel Freer",
                  "F004H61" : "Isabelle Dady",
                  "F004GG5" : "Gracie Dickman",
                  "F004QSS" : "Rohit Garimella",
                  "F004N6S" : "Vikram Strander",
                  "F004PPJ" : "Matt Batista",
                  "F004GB6" : "Caroline Carr",
                  "F004GZ6" : "Grace Farr",
                  "F004H75" : "Elda Kahssay",
                  "F004GCK" : "Eleanor Burke",
                  "F004N44" : "Aliya French",
                  "F004PFP" : "Lilian C. Hemmins",
                  "F0044MW" : "Zoe C. Thierfelder",
                  "F005TMB" : "Ava Neijna",
                  "F004P8B" : "Nicole Tooper",
                  "F0055VT" : "Cooper Puckett",
                  "F004GFC" : "Victoria T. Norchi"
                    ]


let blackDict = ["F004HF0" : "Nicolas Leey Parodi",
                 "F0055PB" : "Shay Desai",
                 "F005DGC" : "Jack D. Cocchiarella",
                 "F003XCK" : "Skye T. Henderson",
                 "F003XYZ" : "William M. Schultz",
                 "F003Y03" : "Alexander N. Nemeth",
                 "F004G9V" : "Devon B. Lingle",
                 "F003X4K" : "Anders F. Gibbons",
                 "F004MSV" : "Clark Gilmore"
                ]

let demoDict = ["F004HBW" : "Jackson Desmond",
                  "F004H1H" : "Katherine L. Levy",
                  "F004GZY" : "Daniel J. Locascio",
                  "F004Y2W" : "Caroline B. Kramer",
                  "F004Q8X" : "Isabelle B. Lewitt"
                ]

