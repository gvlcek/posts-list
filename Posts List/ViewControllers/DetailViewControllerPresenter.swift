//
//  DetailViewControllerPresenter.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 25/01/2023.
//

import Foundation

class DetailViewControllerData {
    var post: Post
    var comments: [Comment]
    
    init(post: Post, comments: [Comment]) {
        self.post = post
        self.comments = comments
    }
}

protocol DetailViewControllerProtocol: AnyObject {
    func loadComments(comments: [Comment])
    func loadUser(user: User)
    func hideCommentsUser()
}

class DetailViewControllerPresenter: DetailViewControllerPresenterProtocol {
    weak var view: DetailViewControllerProtocol?
    private let webService: WebServices

    init(webService: WebServices) {
        self.webService = webService
    }
    
    // MARK: - DetailViewControllerPresenterProtocol
    
    func fetchComments(postId: String) {
        let commentsUrl = "\(Constants.URL_SERVICES.comments)\(postId)"
        webService.getRequest(jsonUrl: commentsUrl, type: Comment.self, completionHandler: { [weak self] response in
            self?.view?.loadComments(comments: response)
        }) { [weak self] (error) in
            self?.view?.hideCommentsUser()
            print("Could not fetch images!")
        }
    }
    
    func fetchAuthor(userId: String) {
        let commentsUrl = "\(Constants.URL_SERVICES.users)\(userId)"
        webService.getRequest(jsonUrl: commentsUrl, type: User.self, completionHandler: { [weak self] response in
            guard let user = response.first else { return }
            self?.view?.loadUser(user: user)
        }) { (error) in
            print("Could not fetch images!")
        }
    }
}

extension DetailViewControllerData {
    convenience init() {
        self.init(post: Post(userId: 0, postId: 0, title: "", body: ""), comments: [])
    }
}
