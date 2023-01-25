//
//  MainViewControllerPresenterTests.swift
//  Posts ListTests
//
//  Created by Guadalupe Vlček on 26/01/2023.
//

import XCTest
@testable import Posts_List

class MainViewControllerPresenterTests: XCTestCase {
    fileprivate var view: MockView!
    fileprivate var subject: MainViewControllerPresenter!
    fileprivate var webservice = MockWebServices()

    override func setUp() {
        super.setUp()

        view = MockView()

        subject = MainViewControllerPresenter(webService: MockWebServices(), coreDataHelper: CoreDataHelper())
        subject.view = view
    }

    override func tearDown() {
        super.tearDown()

        view = nil
        subject = nil
    }

    func test_loadData() {
        view.loadPosts(posts: [Post(userId: 1, postId: 1, title: "", body: ""), Post(userId: 2, postId: 2, title: "", body: "")])
        XCTAssertEqual(view.didFetchPosts, true)
    }
}

fileprivate class MockView: MainViewControllerProtocol {
    var didFetchPosts = false
    func loadPosts(posts: [Posts_List.Post]) {
        didFetchPosts = true
    }
}

fileprivate class MockWebServices: WebServices {
    override func getRequest<T: Codable>(jsonUrl: String, type: T.Type, completionHandler: @escaping ([T]) -> Void, errorHandler: @escaping (String) -> Void) {
    }
}

