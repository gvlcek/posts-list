//
//  MainViewControllerPresenter.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import Foundation

class MainViewControllerData {
    var posts: [Post]
    
    init(posts: [Post]) {
        self.posts = posts
    }
}

protocol MainViewControllerProtocol: AnyObject {
    func loadPosts(posts: [Post])
}

class MainViewControllerPresenter: MainViewControllerPresenterProtocol {    
    weak var view: MainViewControllerProtocol?
    private let webService: WebServices
    private let coreDataHelper: CoreDataHelper

    init(webService: WebServices, coreDataHelper: CoreDataHelper) {
        self.webService = webService
        self.coreDataHelper = coreDataHelper
    }
    
    func updateFavorite(postId: Int, isFavorite: Bool) {
        coreDataHelper.saveFavorite(postId: postId, isFavorite: isFavorite)
    }
    
    func getFavoriteStatus(postId: Int) -> Bool {
        if let status = coreDataHelper.getFavoriteStatus(postId: postId) {
            return status.isFavorite
        } else {
            return false
        }
    }
    
    func getFavorites() -> [Favorite] {
        return coreDataHelper.fetchFavorites()
    }
    
    // MARK: - MainViewControllerPresenterProtocol
    
    func fetchPosts() {
        webService.getRequest(jsonUrl: Constants.URL_SERVICES.posts, type: Post.self, completionHandler: { [weak self] response in
            self?.coreDataHelper.savePosts(posts: response)
            self?.view?.loadPosts(posts: response)
        }) { [weak self] error in
            self?.view?.loadPosts(posts: (self?.coreDataHelper.loadPosts())!)
            print("Could not fetch images!")
        }
    }
}

extension MainViewControllerData {
    convenience init() {
        self.init(posts: [])
    }
}
