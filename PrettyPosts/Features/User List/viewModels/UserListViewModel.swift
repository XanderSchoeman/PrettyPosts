//
//  UserListViewModel.swift
//  PrettyPosts
//
//  Created by Xander Schoeman on 2024/02/28.
//

import Foundation

class UserListViewModel {
    var users: [User] = []
    let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchUsers(completion: @escaping (Result<Void, APIServiceError>) -> Void) {
        apiService.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedUsers):
                    self?.users = fetchedUsers
                    completion(.success(()))
                case .failure(let error):
                    self?.users = []
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
}
