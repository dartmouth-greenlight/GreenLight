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

struct IDLookUp: Decodable {
    let truncated: Bool
    let users: [Student]
}

enum MyError: Error {
    case runtimeError(String)
}


func getName(id: String) -> String {
    //Building URL
    let studentID = id
    var student = ""
    if(studentID.prefix(3)=="f00" || studentID.prefix(3)=="F00"){
        let resourceString = "https://api-lookup.dartmouth.edu/v1/lookup?q=\(studentID)"
        let resourceURL = URL(string: resourceString)
        guard resourceURL != nil else {return "Name not found"}
        
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
                    let students = idlookup.users
                    if(students.isEmpty){
                        student = "No name found"
                        semaphore.signal() // 2. Count it up if no name found
                    }else{
                        student = students[0].displayName
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
        student = "Name not found"
    }
    
    return student
}

//TODO: Separate fetching data from the processing data
func getID(name: String, searchNum: Int? = 1) -> [Person]{
    let original = name
    //Building URL
    var name = name.split(separator: " ")
    var fullName = ""
    
    //TODO: Make this more robust - e.g., let obvious typos still work -- will we be able to use spell check built in on keyboard?
    if searchNum == 1{
        let first = name[0]
        let last = name.removeLast()
        if(first != last && last != " "){
            fullName = first + "_" + last
        }else{
            fullName += first
        }
    }
    
    // Search last name
    else if searchNum == 2 {
        fullName += name.removeLast()
    }
    
    //Search first name
    else if searchNum == 3 {
        fullName += name[0]
    }
    
    let resourceString = "https://api-lookup.dartmouth.edu/v1/lookup?q=\(fullName)"
    let resourceURL = URL(string: resourceString)
    guard resourceURL != nil else {return [Person(name:"", id:"", year:"")]}
    
    let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
    
    // Create URL session
    let session = URLSession.shared
    var names = [Person]()

    // Add more checks for errors, correct response, etc.
    let dataTask = session.dataTask(with: resourceURL!) { (data, response, error) in
        //Check for errors
        if error == nil && data != nil {
            //Parse JSON
            let decoder = JSONDecoder()

            do {
                let idlookup = try decoder.decode(IDLookUp.self, from: data!)
                let students = idlookup.users
                if(students.isEmpty){
                    semaphore.signal() // 2. Count it up if no name found
                }else{
                    for student in students{
                        if(student.uid.prefix(3)=="f00") {
                            if(student.mail !=  nil){
                                
                                // Get class year from email
                                let yearPieces = student.mail!.split(separator: "@")
                                let twoDigYear = yearPieces[0].split(separator: ".")
                                var currYear = ""
                                currYear += twoDigYear.last!
                                
                                //toggle this to include / exclude grad students/older alums
                                if(currYear.prefix(1) == "2"){
                                    if(currYear.prefix(2) == "22" || currYear.prefix(2) == "23" || currYear.prefix(2) == "24" || currYear.prefix(2) == "25" || currYear.prefix(2) == "26") {
                                        let curr = Person(name: student.displayName, id: student.uid, year: currYear)
                                        names.append(curr)
                                    }
                                }
                            }
                        }
                        
                    }
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
    
    if (names.isEmpty && searchNum == 1){
        return getID(name: original, searchNum: 2)
    }else if(names.isEmpty && searchNum == 2){
        return getID(name: original, searchNum: 3)
    }else{
        return names.sorted {
            $0.year < $1.year
        }
    }
}
