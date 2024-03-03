//
//  PostListViewModelTests.swift
//  PrettyPostsTests
//
//  Created by Xander Schoeman on 2024/03/03.
//

import XCTest
@testable import PrettyPosts

final class PostListViewModelTests: XCTestCase {
    
    var viewModel: PostListViewModel!
    var mockAPIService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = PostListViewModel(apiService: mockAPIService)
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }

    func testFetchPostsSuccess() {
        let expectation = self.expectation(description: "Fetch Posts")
        let post = Post(userId: 1, id: 1, title: "eXactly right?", body: "A message describing what exactly happened")
        mockAPIService.fetchPostsResult = .success([post])

        viewModel.fetchPosts(for: 1) { result in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(self.viewModel.posts.count, 1)
        XCTAssertEqual(self.viewModel.posts.first?.title, "eXactly right?")
    }

    func testFetchPostsFailure() {
        let expectation = self.expectation(description: "Fetch Posts Failure")
        mockAPIService.fetchPostsResult = .failure(.networkError(NSError(domain: "", code: -1, userInfo: nil)))

        var fetchError: APIServiceError?
        viewModel.fetchPosts(for: 1) { result in
            if case .failure(let error) = result {
                fetchError = error
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchError)
    }
}
