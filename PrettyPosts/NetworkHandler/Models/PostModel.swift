//
//  PostModel.swift
//  PrettyPosts
//
//  Created by Xander Schoeman on 2024/02/28.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
