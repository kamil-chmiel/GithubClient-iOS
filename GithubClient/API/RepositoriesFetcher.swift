//
//  RepositoriesFetcher.swift
//  GithubClient
//
//  Created by Kamil Chmiel on 29.04.2018.
//  Copyright © 2018 Kamil Chmiel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct RepositoriesFetcher {
    let networking: Networking
    
    func fetch(response: @escaping ([Repository]?) -> ()) {
        networking.request { data in
            let repositories = data.map { self.decode(data: $0) }
            response(repositories!)
        }
    }
    
    private func decode(data: NSData) -> [Repository]? {
        var json = JSON()
        var repositories = [Repository]()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
        
        do {
            json = try JSON(data: data as Data)
        } catch {
            print("Parsing JSON error: \(error)")
        }
        
        if let objectsArray = json.array {
            
            for jsonObject in objectsArray {
                if let id = jsonObject["id"].int {
                    
                    let repository = Repository(
                        id: id,
                        title: jsonObject["name"].stringValue,
                        description: jsonObject["description"].stringValue,
                        language: jsonObject["language"].stringValue,
                        created: formatter.date(from: jsonObject["created_at"].stringValue)!,
                        updated: formatter.date(from: jsonObject["updated_at"].stringValue)!,
                        pushed: formatter.date(from: jsonObject["pushed_at"].stringValue)!,
                        size: jsonObject["size"].int!,
                        privacy: jsonObject["private"].bool!,
                        license: jsonObject["license"].string ?? "None")
                    repositories.append(repository)
                }
            }
        }
        else {
            return nil
        }
        return repositories
    }
}
