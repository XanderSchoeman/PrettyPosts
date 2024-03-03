//
//  UserListViewModelTests.swift
//  PrettyPostsTests
//
//  Created by Xander Schoeman on 2024/03/03.
//

import XCTest
@testable import PrettyPosts

final class UserListViewModelTests: XCTestCase {

    var viewModel: UserListViewModel!
    var mockAPIService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = UserListViewModel(apiService: mockAPIService)
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        let expectation = self.expectation(description: "Fetch Users")
        let user = User(id: 1, name: "Xander Schoeman", username: "thexman", email: "thex@example.com", address: Address(street: "123 X Street", suite: "Hotel X", city: "Xtown", zipcode: "0232"))
        mockAPIService.fetchUsersResult = .success([user])

        viewModel.fetchUsers { result in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users.first?.name, "Xander Schoeman")
    }

    func testFetchUsersFailure() {
        let expectation = self.expectation(description: "Fetch Users failure")
        mockAPIService.fetchUsersResult = .failure(.networkError(NSError(domain: "", code: -1, userInfo: nil)))

        var fetchError: APIServiceError?
        viewModel.fetchUsers { result in
            if case .failure(let error) = result {
                fetchError = error
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchError)
    }
}
