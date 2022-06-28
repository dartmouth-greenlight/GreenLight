//
//  lookupAPIs.swift
//  GreenLight
//
//  Created by Jack Desmond on 6/27/22.
//

import Foundation

// sections of the json object the api returns
struct IDLookUp: Codable {
    let truncated: Bool
    let users: [User]
}

struct User: Codable {
    let uid, eduPersonPrimaryAffiliation, mail, displayName: String
}

func getName(id: String) -> String {
    //Building URL
    let studentID = id
    let resourceString = "https://api-lookup.dartmouth.edu/v1/lookup?q=\(studentID)"
    let resourceURL = URL(string: resourceString)
    guard resourceURL != nil else {return "Name not found"}
    let session = URLSession.shared
    var user = ""

    let dataTask = session.dataTask(with: resourceURL!) { (data, response, error) in
        //Check for errors
        if error == nil && data != nil {
            //Parse JSON
            let decoder = JSONDecoder()

            do {
                let idlookup = try decoder.decode(IDLookUp.self, from: data!)
                let users = idlookup.users
                user = users[0].displayName

            }
            catch {
                print(error)
            }
        }
    }
    dataTask.resume()
    if(user != ""){
        return user
    } else{
        return "Name not found"
    }
}

func getID(name: String) {
    //Building URL
    var name = name.split(separator: " ")
    let first = name[0]
    let last = name.removeLast()
    let fullName = first + "_" + last
    let resourceString = "https://api-lookup.dartmouth.edu/v1/lookup?q=\(fullName)"
    let resourceURL = URL(string: resourceString)
    guard resourceURL != nil else {return}
    let session = URLSession.shared

    let dataTask = session.dataTask(with: resourceURL!) { (data, response, error) in
        //Check for errors
        if error == nil && data != nil {
            //Parse JSON
            let decoder = JSONDecoder()

            do {
                let idlookup = try decoder.decode(IDLookUp.self, from: data!)
                let users = idlookup.users
                let user = users[0].uid
                print(user)
                
            }
            catch {
                print(error)
            }
        }
    }
    dataTask.resume()
}
