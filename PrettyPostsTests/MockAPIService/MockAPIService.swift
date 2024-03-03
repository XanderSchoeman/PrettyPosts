//
//  MockAPIService.swift
//  PrettyPostsTests
//
//  Created by Xander Schoeman on 2024/03/03.
//

import Foundation

class MockAPIService: APIServiceProtocol {
    var fetchUsersResult: Result<[User], APIServiceError>?
    var fetchPostsResult: Result<[Post], APIServiceError>?

    func fetchUsers(completion: @escaping (Result<[User], APIServiceError>) -> Void) {
        if let result = fetchUsersResult {
            completion(result)
        }
    }

    func fetchPosts(for userId: Int, completion: @escaping (Result<[Post], APIServiceError>) -> Void) {
        if let result = fetchPostsResult {
            completion(result)
        }
    }
}
