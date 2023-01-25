//
//  DetailViewController.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 25/01/2023.
//

import UIKit

protocol DetailViewControllerPresenterProtocol {
    func fetchComments(postId: String)
    func fetchAuthor(userId: String)
}

class DetailViewController: UIViewController, DetailViewControllerProtocol, UITableViewDataSource, UITableViewDelegate {
    private var viewData = DetailViewControllerData()
    private var presenter: DetailViewControllerPresenterProtocol
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet weak var userStackView: UIStackView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    init(presenter: DetailViewControllerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(post: Post) {
        viewData.post = post
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DetailViewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier:  DetailViewTableViewCell.identifier)
        
        postBodyLabel.text = viewData.post.body
        postTitleLabel.text = viewData.post.title
        
        presenter.fetchComments(postId: viewData.post.postId.description)
        presenter.fetchAuthor(userId: viewData.post.userId.description)
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.beginRefreshingManually()
    }
    
    // MARK: - DetailViewControllerProtocol
    
    func loadComments(comments: [Comment]) {
        viewData.comments = comments
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func loadUser(user: User) {
        DispatchQueue.main.async { [weak self] in
            self?.title = user.name
            self?.usernameLabel.text = user.username
            self?.emailLabel.text = user.email
        }
    }
    
    func hideCommentsUser() {
        DispatchQueue.main.async { [weak self] in
            self?.userStackView.isHidden = true
            self?.tableView.isHidden = true
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "MainView_detail_comments".localized()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewTableViewCell.identifier, for: indexPath) as! DetailViewTableViewCell
        cell.populate(comment: viewData.comments[indexPath.row])
        return cell
    }
}
