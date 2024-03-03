//
//  PostListViewModel.swift
//  PrettyPosts
//
//  Created by Xander Schoeman on 2024/02/28.
//

import Foundation

class PostListViewModel {
    var posts: [Post] = []
    let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchPosts(for userId: Int, completion: @escaping (Result<Void, APIServiceError>) -> Void) {
        apiService.fetchPosts(for: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedPosts):
                    self?.posts = fetchedPosts
                    completion(.success(()))
                case .failure(let error):
                    self?.posts = []
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
}
