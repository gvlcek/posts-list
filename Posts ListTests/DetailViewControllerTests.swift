//
//  DetailViewControllerTests.swift
//  Posts ListTests
//
//  Created by Guadalupe Vlček on 26/01/2023.
//

import XCTest
@testable import Posts_List

class DetailViewControllerTests: XCTestCase {
    var subject: DetailViewController!
    private var presenter: MockDetailViewControllerPresenter!

    override func setUp() {
        super.setUp()
        presenter = MockDetailViewControllerPresenter()
        subject = DetailViewController(presenter: presenter)
        subject.loadUser(user: User(userId: 1, name: "", username: "", email: "", address: Address(street: "", suite: "", city: "", zipCode: nil, geo: Geolocalization(latitude: "", longitude: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: "")))
        subject.loadComments(comments: [Comment(postId: 1, commentId: 1, name: "", email: "", body: "")])
        
        _ = subject.view
    }
    
    func test_viewDidLoadCallsFetchAuthor() {
        XCTAssertEqual(presenter.didFetchAuthor, true)
    }
    
    func test_viewDidLoadCallsFetchComments() {
        XCTAssertEqual(presenter.didFetchComments, true)
    }
}

fileprivate class MockDetailViewControllerPresenter: DetailViewControllerPresenterProtocol {
    var didFetchComments = false
    func fetchComments(postId: String) {
        didFetchComments = true
    }
    
    var didFetchAuthor = false
    func fetchAuthor(userId: String) {
        didFetchAuthor = true
    }
}


