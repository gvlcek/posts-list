//
//  MainViewTableViewCellTests.swift
//  Posts ListTests
//
//  Created by Guadalupe Vlček on 26/01/2023.
//

import XCTest
@testable import Posts_List

class ImportedMapsPageTableViewCellTests: XCTestCase {
    private var delegate: MockMainTableViewCellDelegate!
    var subject: MainViewTableViewCell!

    override func setUp() {
        super.setUp()
        
        delegate = MockMainTableViewCellDelegate()
        subject = MainViewTableViewCell(style: .value1, reuseIdentifier: "")
    }

    func test_UserDidSelectFavorite() {
        let viewData = getTestViewData()
        subject.delegate = delegate
        subject.delegate?.userDidSelectFavorite(postId: 1, isFavorite: true)
        XCTAssertEqual(delegate.isFavoriteSelected, true)
    }

    private func getTestViewData() -> MainViewControllerData {
        let posts = [Post(userId: 1, postId: 1, title: "", body: ""), Post(userId: 2, postId: 2, title: "", body: "")]
        return MainViewControllerData(posts: posts)
    }
}

fileprivate class MockMainTableViewCellDelegate: MainViewTableViewCellDelegate {
    var isFavoriteSelected = false
    func userDidSelectFavorite(postId: Int, isFavorite: Bool) {
        isFavoriteSelected = true
    }
}
