//
//  MainViewControllerTests.swift
//  Posts ListTests
//
//  Created by Guadalupe Vlček on 26/01/2023.
//

import XCTest
@testable import Posts_List

class MainViewControllerTests: XCTestCase {
    var subject: MainViewController!
    private var presenter: MockMainViewControllerPresenter!

    override func setUp() {
        super.setUp()

        presenter = MockMainViewControllerPresenter()
        subject = MainViewController(presenter: presenter)
        subject.loadPosts(posts: [Post(userId: 1, postId: 1, title: "title", body: "body")])
        
        _ = subject.view
    }
    
    func test_GetFavorite() {
        XCTAssertEqual(presenter.getFavorites().count, 1)
    }
    
    func test_viewDidLoadCallsFetchPosts() {
        XCTAssertEqual(presenter.didFetchPosts, true)
    }
    
    func test_PresenterUpdateFavorite() {
        presenter.updateFavorite(postId: 12, isFavorite: true)
        XCTAssertEqual(presenter.isUpdated, true)
    }
    
    func test_GetFavoriteStatus() {
        presenter.getFavoriteStatus(postId: 12)
        XCTAssertEqual(presenter.favoriteStatus, true)
    }
}

fileprivate class MockMainViewControllerPresenter: MainViewControllerPresenterProtocol {
    func getFavorites() -> [Posts_List.Favorite] {
        let favorite = Favorite()
        return [favorite]
    }
    
    var didFetchPosts = false
    func fetchPosts() {
        didFetchPosts = true
    }
    
    var isUpdated = false
    func updateFavorite(postId: Int, isFavorite: Bool) {
        isUpdated = true
    }
    
    var favoriteStatus = false
    func getFavoriteStatus(postId: Int) -> Bool {
        favoriteStatus = true
        return true
    }
}

