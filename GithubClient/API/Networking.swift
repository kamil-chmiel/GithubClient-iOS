//
//  Networking.swift
//  GithubClient
//
//  Created by Kamil Chmiel on 29.04.2018.
//  Copyright © 2018 Kamil Chmiel. All rights reserved.
//

import Foundation

protocol Networking {
    func request(response: @escaping (NSData?) -> ())
}
