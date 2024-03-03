//
//  PostListViewController.swift
//  PrettyPosts
//
//  Created by Xander Schoeman on 2024/02/28.
//

import Foundation
import UIKit

class PostListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PostListViewModel!
    var selectedUserId: Int?
    var selectedUserName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel = PostListViewModel()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()
        fetchPosts(for: selectedUserId ?? 0)
    }
    
    // MARK: - Setup
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostCell")
        tableView.separatorStyle = .singleLine
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        if let userName = selectedUserName {
            self.title = "\(userName)'s Posts"
        } else {
            self.title = "Posts"
        }
    }
    
    // MARK: - Network
    private func fetchPosts(for userId: Int) {
        viewModel.fetchPosts(for: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.presentError(error)
                }
            }
        }
    }
    
    // MARK: - Error Handling
    private func presentError(_ error: APIServiceError) {
        let alert = UIAlertController(title: "Error", message: "An error occurred: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

// MARK: - TableView
extension PostListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        let post = viewModel.posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
