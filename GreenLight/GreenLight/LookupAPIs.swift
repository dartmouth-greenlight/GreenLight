//
//  lookupAPIs.swift
//  GreenLight
//
//  Created by Jack Desmond on 6/27/22.
//  Authored by Tucker Simpson and Jack Desmond
//

import Foundation

//TODO: Make more robust for typos, nicknames, common names, etc.

// sections of the json object the api returns
struct IDLookUp: Codable {
    let truncated: Bool
    let users: [User]
}

struct User: Codable {
    let uid, eduPersonPrimaryAffiliation, mail, displayName: String
}

enum MyError: Error {
    case runtimeError(String)
}

func getName(id: String) -> String {
    //Building URL
    let studentID = id
    var user = ""
    if(studentID.prefix(3)=="f00" || studentID.prefix(3)=="F00"){
        let resourceString = "https://api-lookup.dartmouth.edu/v1/lookup?q=\(studentID)"
        let resourceURL = URL(string: resourceString)
        guard resourceURL != nil else {return "Name not found."}
        
        let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
        
        // Create URL session
        let session = URLSession.shared

        // Add more checks for errors, correct response, etc.
        let dataTask = session.dataTask(with: resourceURL!) { (data, response, error) in
            //Check for errors
            if error == nil && data != nil {
                //Parse JSON
                let decoder = JSONDecoder()

                do {
                    let idlookup = try decoder.decode(IDLookUp.self, from: data!)
                    let users = idlookup.users
                    if(users.isEmpty){
                        user = "No name found."
                        semaphore.signal() // 2. Count it up if no name found
                    }else{
                        user = users[0].displayName
                        semaphore.signal()  //2. Count it up
                    }

                }
                catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
        
        semaphore.wait()    // 3. Wait for semaphore
    }else{
        user = "Name not found."
    }
    
    return user
}

func getID(name: String) -> String{
    //Building URL
    var name = name.split(separator: " ")
    let first = name[0]
    let last = name.removeLast()
    let fullName = first + "_" + last
    let resourceString = "https://api-lookup.dartmouth.edu/v1/lookup?q=\(fullName)"
    let resourceURL = URL(string: resourceString)
    guard resourceURL != nil else {return "ID not found."}
    
    let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
    
    // Create URL session
    let session = URLSession.shared
    var user = ""

    // Add more checks for errors, correct response, etc.
    let dataTask = session.dataTask(with: resourceURL!) { (data, response, error) in
        //Check for errors
        if error == nil && data != nil {
            //Parse JSON
            let decoder = JSONDecoder()

            do {
                let idlookup = try decoder.decode(IDLookUp.self, from: data!)
                let users = idlookup.users
                if(users.isEmpty){
                    user = "No name found."
                    semaphore.signal() // 2. Count it up if no name found
                }else{
                    // Need better handle of case where have common name
                    user = users[0].uid
                    semaphore.signal()  //2. count it up
                }

            }
            catch {
                print(error)
            }
        }
    }
    dataTask.resume()
    
    semaphore.wait()    // 3. Wait for semaphore
    
    return user
}
