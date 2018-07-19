//
//  Repository.swift
//  GithubClient
//
//  Created by Kamil Chmiel on 29.04.2018.
//  Copyright © 2018 Kamil Chmiel. All rights reserved.
//

import Foundation

struct Repository {
    let id: Int
    let title: String
    let description: String
    let language: String
    let created: Date
    let updated: Date
    let pushed: Date
    let size: Int
    let privacy: Bool
    let license: String
}
