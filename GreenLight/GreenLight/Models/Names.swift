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

let betapalooza = ["F004H5D" : "Madison Blanche",
                   "F004H08" : "Mia McClure",
                   "F004XMS" : "Sídney Marsh",
                   "F004H9R" : "Kendall Weingart",
                   "F004Q86" : "Nellie Ryan",
                   "F004GHX" : "Kristin Chapman",
                   "F004GDG" : "Reed Cole",
                   "F004H0M" : "Abby Salzhauer",
                   "F004PPP" : "Anna K. Ray",
                   "F004GHZ" : "Lexi Dewire",
                   "F004GG7" : "Lily Scott",
                   "F004H91" : "Omala Snyder",
                   "F004R1G" : "Elizabeth Adams",
                   "F004Q2G" : "Amy Morrissey",
                   "F004GGZ" : "Ruby Donaghu",
                   "F004H3Q" : "Liana Laremont",
                   "F004GQG" : "Willa Shannon",
                   "F004XPQ" : "Emily Gao",
                   "F004PKY" : "Alina Chadwick",
                   "F004GVV" : "Amelia Gibbs",
                   "F004NVQ" : "Lauren Lee",
                   "F004H0D" : "Caroline Oyster",
                   "F004H5B" : "Julia Binder",
                   "F004G9H" : "Harley Kell",
                   "F004S19" : "Ella Von Baeyer",
                   "F004GGC" : "Anna Brause",
                   "F004GC5" : "Bella Godsick",
                   "F004HCZ" : "Hannah Sheehy",
                   "F004GZ6" : "Grace Farr",
                   "F004R15" : "Vicki Peterlin",
                   "F004NQT" : "Cassidy Wechter",
                   "F00449T" : "Esme Lee",
                   "F004GB5" : "Ellie Blain",
                   "F004GBT" : "Carrington Washburn",
                   "F004GR0" : "Annie Nolan",
                   "F004N33" : "Meghan O'Keefe",
                   "F004Y2W" : "Caroline B. Kramer",
                   "F004GDR" : "Megan Lynch",
                   "F004GRD" : "Maya Nguyen",
                   "F004GTN" : "Rachel Freer",
                   "F004GC3" : "Camryn Foltz",
                   "F004Y38" : "Claire Macedonia",
                   "F004RXV" : "Annie Burton",
                   "F004H75" : "Elda Kahssay",
                   "F004MPX" : "Zoe Moon",
                   "F004GZD" : "Isabella Hamlen",
                   "F004P7P" : "Lynne Li",
                   "F004GF2" : "Grace Faulkner",
                   "F004HD1" : "Taylor Williams",
                   "F004G9C" : "Karen Murphy",
                   "F004H6S" : "Natalie Grover",
                   "F004GG9" : "Abbey Savin",
                   "F004GDY" : "Diana Bates",
                   "F004XN1" : "India Tehranchi",
                   "F004GM2" : "Avery Fogg",
                   "F004MR6" : "Rachel Zhang",
                   "F004MSK" : "Sydney Rosenbaum",
                   "F004Q8X" : "Isabelle Lewitt",
                   "F004H7F" : "Agatha la Voie",
                   "F004PT5" : "Renesa Khanna",
                   "F004GJ3" : "Julia Gottschalk",
                   "F004GM4" : "Annabel Gerber",
                   "F004GDM" : "Grace Mensi",
                   "F004GVN" : "Jenna Martin",
                   "F004H61" : "Isabelle Dady",
                   "F004N4G" : "Isa Robinson",
                   "F004N5X" : "Christine Wu",
                   "F004N44" : "Aliya French",
                   "F004MQV" : "Emma Merlini",
                   "F004GYG" : "Aspen Anderson",
                   "F004GQY" : "Daisy Granholm",
                   "F004GGN" : "Tamer Luzi",
                   "F0044T8" : "Eden Schneck",
                   "F004PFP" : "Lilian C. Hemmins",
                   "F004GZG" : "Rachel Horne",
                   "F004R8D" : "Elizabeth Frey",
                   "F004N3W" : "Chloe Park",
                   "F004GT9" : "Peyton Bond",
                   "F004GD7" : "Payton Altman",
                   "F004PG4" : "Stephanie Lee",
                   "F004H1J" : "Elizabeth Ding",
                   "F004GCS" : "Carly Retterer",
                   "F004MQC" : "Marguerite Morgan",
                   "F004GG5" : "Gracie Dickman",
                   "F004H1H" : "Katherine Levy",
                   "F004H9X" : "Solenne Wolfe",
                   "F004GTF" : "Audrey Craighead",
                   "F003WV4" : "Anna Politi",
                   "F004NKH" : "Eleanor Schifino",
                   "F004MSC" : "Cori Hoffer",
                   "F004H9D" : "Katherine Takoudes",
                   "F004GYP" : "Kayleigh Bowler",
                   "F004R97" : "Lindsey Kim",
                   "F004GFO" : "Lila Browne",
                   "F004GD5" : "Victoria Williamson",
                   "F004Y2Y" : "Catherine Grimes",
                   "F004GCH" : "Bronwyn Bird",
                   "F004R1P" : "Aurelie J. Temsamani",
                   "F004P5V" : "Lauren Hwang",
                   "F004GJ1" : "Skye Ekern",
                   "F00489Z" : "Sarah Palmer",
                   "F0043VQ" : "Celeste D'Costa Ulicki",
                   "F004GFC" : "Victoria Norchi",
                   "F004H8F" : "Anna Pahl",
                   "F004GN2" : "Natalie Shapiro",
                   "F004GZT" : "Emily Levonas",
                   "F004MSN" : "Adriana Chavira-Ochoa",
                   "F004PPD" : "Grace Gallant",
                   "F004MT5" : "Adin McAuliffe",
                   "F003X2J" : "Luca Romualdez",
                   "F004VTZ" : "Teddy Wavle",
                   "F004GTH" : "Teddy Danziger",
                   "F004HCX" : "Street Roberts",
                   "F004N58" : "Sam Williams",
                   "F004S7V" : "Sebastian Riano",
                   "F004Y3B" : "Sam O'Donnell",
                   "F003WPW" : "Oscar Lee",
                   "F003YG7" : "Nick Weaving",
                   "F004H8K" : "Ned Rae Smith",
                   "F004GS0" : "Mike Walkosz",
                   "F004MTX" : "Luke Marshall",
                   "F004QMY" : "Logan Chang",
                   "F004MSZ" : "Levi Port",
                   "F004NW8" : "Justin Stevens",
                   "F004Q2X" : "Josh Vorbrich",
                   "F004HBW" : "Jack Desmond",
                   "F004GRG" : "Brody Thompson",
                   "F004PXY" : "Avery Sholes",
                   "F0044BB" : "Asher Vogel",
                   "F004H1Z" : "Alan Moss",
                   "F004PKM" : "Thomas Policicchio",
                   "F004R8J" : "Thomas Bevevino",
                   "F004Q8S" : "Tejas Parekh",
                   "F004GWX" : "Satchel Williams",
                   "F004QSS" : "Rohit Garimella",
                   "F004GYM" : "Jimmy Bohn",
                   "F004H5S" : "Jihwan Choi",
                   "F004R9B" : "Henry Exall",
                   "F004S30" : "Ben Wilkins",
                   "F004N6C" : "Matt Pfundstein",
                   "F004G9V" : "Devon Lingle",
                   "F004GZ2" : "Jack Dyett",
                   "F004NKZ" : "Jeff Liu",
                   "F004GZ4" : "Ben Fagell",
                   "F004ND1" : "Ben Traugott",
                   "F004MRW" : "Andrew Doerr",
                   "F004GVZ" : "Ethan Weinstein",
                   "F004MRG" : "Nick Hepburn",
                   "F004H2X" : "Max Weinstein",
                   "F004H04" : "Rob Mailley",
                   "F004TCV" : "Ryan Irving",
                   "F0041RP" : "Seamus O'Connell",
                   "F004GN6" : "Chris Sole",
                   "F004H9P" : "Gonzalo Villalba",
                   "F004H3H" : "Andrew Briley",
                   "F004QC4" : "Karim Khalil",
                   "F004GGS" : "Owen Lee",
                   "F004XMZ" : "Liam Murphy",
                   "F004GX1" : "Hunter Binney",
                   "F004YBZ" : "Hugh Jones",
                   "F004P5X" : "Jack Trahan",
                   "F004H39" : "Tucker Simpson",
                   "F004GZY" : "Danny Locascio",
                   "F004HBC" : "Christian Beck",
                   "F004QC6" : "Kieran Norton",
                   "F004PFR" : "Parker Jones",
                   "F004H8H" : "Josh Pfefferkorn",
                   "F004N71" : "Derek Elsholz",
                   "F004G8S" : "Cade Keesling",
                   "F004H95" : "Ryan Sorkin",
                   "F003XYK" : "Max Martin",
                   "F004G9K" : "Daniel Coons",
                   "F004MRX" : "Tom Collins",
                   "F003XVH" : "Joeseph Musa",
                   "F004NQJ" : "Charlie Baker",
                   "F004GH1" : "Davis Leath",
                   "F004HC6" : "Elliot Kim",
                   "F0041HW" : "Ethan Swergold",
                   "F004GY8" : "Ethan Litmans",
                   "F0042BS" : "Jack Chorley",
                   "F004GGH" : "Jack Cooleen",
                   "F0044TT" : "Jack Reilly",
                   "F004HCS" : "Jason Norris",
                   "F004H16" : "John Zavras",
                   "F004N26" : "Orrett Maine",
                   "F004HD9" : "Momodou Jaata",
                   "F004HCC" : "Justin King",
                   "F004XN4" : "Kevin King",
                   "F004H4D" : "Neechi Ombima",
                   "F004HF0" : "Nico Leey",
                   "F004H8C" : "Oluwafolabomi Ogunlari",
                   "F004MRT" : "Tevita Moimoi",
                   "F004MQ3" : "Marquist Allen",
                   "F004GB3" : "Nico Sani",
                   "F004NMH" : "Mia Curtis",
                   "F004GM8" : "Jake Headrick",
                   "F004Y8X" : "Jameson Liljedahl",
                  "F004H7C" : "Andrew Koulogeorge",
                  "F004N7X" : "Kamil Salame",
                  "F004MPG" : "Jarmone Sutherland",
                  "F004N84" : "Ross Parrish",
                  "F004H54" : "Rahul Batlanki",
                  "F004GS8" : "Teani De Fries",
                  "F004GZ0" : "Lily Ding",
                  "F004P7R" : "Zitao Li",
                  "F004GFK" : "Sophia Franco",
                  "F004GKM" : "Cam Calcano",
                  "F004GCK" : "Eleanor Burke",
                  "F004HQQ" : "Hannah Ren",
                  "F004GCF" : "Madeline A. Hawkins",
                  "F004NWG" : "Neha Agarwal",
                  "F004G95" : "Olivia Holm",
                  "F004GTZ" : "Rosemary McCarthy",
                  "F004GPM" : "Rujuta Pandit",
                  "F004GY6" : "Valentina Fernandez",
                  "F0044MW" : "Zoe Thierfelder",
                  "F004NKK" : "Yumi Yoshiyasu",
                  "F004GJ9" : "Rem Katyal",
                  "F004MR8" : "Emily Osman",
                  "F004XDW" : "Hannah Tanenbaum",
                  "F004GF5" : "Will Kalikman",
                  "F004GZ8" : "Colin Glew",
                  "F004GYB" : "Ryan Lovett",
                  "F004N7Q" : "Brendan Berkman",
                  "F004N73" : "Jack Gnibus",
                  "F004N7Z" : "Addison Textor",
                  "F003XRK" : "Alejandro Quinones",
                  "F006969" : "Legend"]

let kkg = ["F004GG9" : "Abbey Savin",
           "F004H7F" : "Agatha la Voie",
           "F004PKY" : "Alina Chadwick",
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

let blackDict = ["F003Y2H" : "Jaime Chiudian",
                 "F00448K" : "Brody Karton",
                 "F00424N" : "Darren Nelson",
                 "F003KQN" : "Sean Kim",
                 "F003XCK" : "Skye Henderson",
                 "F005GDC" : "Jack Cocchiarella",
                 "F004TWS" : "Grady Bohen",
                 "F004GCQ" : "Jovani Orta",
                 "F0055N7" : "Mccoy Buchsteiner",
                 "F004H1V" : "Taka Khoo"]

