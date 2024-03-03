//
//  APIService.swift
//  PrettyPosts
//
//  Created by Xander Schoeman on 2024/02/28.
//

import Foundation

enum APIServiceError: Error {
    case urlError
    case networkError(Error)
    case decodingError(Error)
    case invalidResponse
    case invalidStatusCode(Int)
}

protocol APIServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], APIServiceError>) -> Void)
    func fetchPosts(for userId: Int, completion: @escaping (Result<[Post], APIServiceError>) -> Void)
}

class APIService: APIServiceProtocol {
    
    func fetchUsers(completion: @escaping (Result<[User], APIServiceError>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
    
    func fetchPosts(for userId: Int, completion: @escaping (Result<[Post], APIServiceError>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/posts?userId=\(userId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}
