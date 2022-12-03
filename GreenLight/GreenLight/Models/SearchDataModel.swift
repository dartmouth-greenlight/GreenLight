//
//  SearchDataModel.swift
//  GreenLight
//
//  Created by Jack Desmond on 8/5/22.
//

import Foundation

class SearchDataModel {
    private var datatask: URLSessionDataTask?
    
    func loadUsers(searchTerm: String, completion: @escaping([Student]) -> Void) {
        datatask?.cancel()
        guard let url = buildURL(forterm: searchTerm) else {
            completion([])
            return
        }
        
        datatask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion([])
                return
            }
            
            if let searchPeopleResponse = try? JSONDecoder().decode(SearchPeopleResponse.self, from: data) {
                completion(searchPeopleResponse.users)
            }
        }
        datatask?.resume()
    }
    
    
    private func buildURL(forterm searchTerm: String) -> URL? {
        guard !searchTerm.isEmpty else { return nil }
        
        var components = URLComponents(string: "https://api-lookup.dartmouth.edu/v1/lookup")
        components?.queryItems = [URLQueryItem(name: "q", value: searchTerm),URLQueryItem(name: "includeAlum", value: "false")]
        
        return components?.url
    }
}

struct SearchPeopleResponse: Decodable {
    let truncated: Bool
    let users: [Student]
}

struct Student: Decodable {
    let uid : String
    let mail: Optional<String>
    let eduPersonPrimaryAffiliation: String
    let displayName: String
}
