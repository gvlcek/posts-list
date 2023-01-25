//
//  DetailViewControllerPresenterTests.swift
//  Posts ListTests
//
//  Created by Guadalupe Vlček on 26/01/2023.
//

import XCTest
@testable import Posts_List

class DetailViewControllerPresenterTests: XCTestCase {
    fileprivate var view: MockView!
    fileprivate var subject: DetailViewControllerPresenter!
    fileprivate var webservice = MockWebServices()

    override func setUp() {
        super.setUp()

        view = MockView()

        subject = DetailViewControllerPresenter(webService: MockWebServices())
        subject.view = view
    }

    override func tearDown() {
        super.tearDown()

        view = nil
        subject = nil
    }

    func test_loadUser() {
        view.loadUser(user: User(userId: 1, name: "", username: "", email: "", address: Address(street: "", suite: "", city: "", zipCode: nil, geo: Geolocalization(latitude: "", longitude: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: "")))
        XCTAssertEqual(view.didLoadUser, true)
    }
    
    func test_loadComments() {
        view.loadComments(comments: [Comment(postId: 1, commentId: 1, name: "", email: "", body: "")])
        XCTAssertEqual(view.commentsCount, 1)
    }
    
    func test_hideComments() {
        view.hideCommentsUser()
        XCTAssertEqual(view.didHideComments, true)
    }
}

fileprivate class MockView: DetailViewControllerProtocol {
    var didLoadUser = false
    func loadUser(user: Posts_List.User) {
        didLoadUser = true
    }
    
    var commentsCount = 0
    func loadComments(comments: [Posts_List.Comment]) {
        commentsCount = comments.count
    }
    
    var didHideComments = false
    func hideCommentsUser() {
        didHideComments = true
    }
}

fileprivate class MockWebServices: WebServices {
    override func getRequest<T: Codable>(jsonUrl: String, type: T.Type, completionHandler: @escaping ([T]) -> Void, errorHandler: @escaping (String) -> Void) {
    }
}

