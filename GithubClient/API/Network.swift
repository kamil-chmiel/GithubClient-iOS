//
//  Network.swift
//  GithubClient
//
//  Created by Kamil Chmiel on 29.04.2018.
//  Copyright © 2018 Kamil Chmiel. All rights reserved.
//

import Foundation
import Alamofire

struct Network : Networking {
    
    func request(response: @escaping (NSData?) -> ()) {
        print(GithubAPI.url)
        Alamofire.request(GithubAPI.url, method: .get)
            .response { data in
                response((data.data! as NSData))
        }
    }
}
