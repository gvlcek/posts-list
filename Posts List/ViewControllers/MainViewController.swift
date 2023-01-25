//
//  MainViewController.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import UIKit

private enum MainSections: Int, CaseIterable {
    case favorites
    case posts
}

protocol MainViewControllerPresenterProtocol {
    func getFavorites() -> [Favorite]
    func fetchPosts()
    func updateFavorite(postId: Int, isFavorite: Bool)
    func getFavoriteStatus(postId: Int) -> Bool
}

class MainViewController: UIViewController, MainViewControllerProtocol, UITableViewDataSource, UITableViewDelegate, MainViewTableViewCellDelegate {
    private var viewData = MainViewControllerData()
    private var presenter: MainViewControllerPresenterProtocol
    @IBOutlet private weak var tableView: UITableView!
    
    init(presenter: MainViewControllerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MainView_title".localized()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MainViewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier:  MainViewTableViewCell.identifier)
        
        // Remove Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(addTapped))
        
        // pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.beginRefreshingManually()
        
        presenter.fetchPosts()
    }
    
    @objc private func pullToRefresh() {
        presenter.fetchPosts()
    }
    
    @objc private func addTapped() {
        let alert = UIAlertController(title: nil, message: "MainView_alert_title".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "MainView_alert_delete".localized(), style: .default, handler: { [weak self] _ in
            self?.removePosts()
        }))
        alert.addAction(UIAlertAction(title: "MainView_alert_cancel".localized(), style: .cancel))
        present(alert, animated: true)
    }
    
    func removePosts() {
        viewData.posts.removeAll(where: { !presenter.getFavoriteStatus(postId: $0.postId) })
        tableView.reloadSections([MainSections.posts.rawValue], with: .none)
    }
    
    // MARK: - MainViewControllerProtocol
    
    func loadPosts(posts: [Post]) {
        viewData = MainViewControllerData(posts: posts)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MainSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == MainSections.favorites.rawValue ? presenter.getFavorites().count : viewData.posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == MainSections.favorites.rawValue {
            return presenter.getFavorites().count == 0 ? 0 : tableView.sectionHeaderHeight
        } else {
            return viewData.posts.count == 0 ? 0 : tableView.sectionHeaderHeight
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == MainSections.favorites.rawValue ? "MainView_section_favorites".localized() : "MainView_section_posts".localized()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == MainSections.posts.rawValue && presenter.getFavoriteStatus(postId: viewData.posts[indexPath.row].postId) {
            return 0
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == MainSections.favorites.rawValue {
            let postId = Int(presenter.getFavorites()[indexPath.row].postId)
            let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.identifier, for: indexPath) as! MainViewTableViewCell
            cell.isFavorite = presenter.getFavoriteStatus(postId: postId)
            cell.post = viewData.posts.first(where: { $0.postId == postId })
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.identifier, for: indexPath) as! MainViewTableViewCell
            cell.isFavorite = presenter.getFavoriteStatus(postId: viewData.posts[indexPath.row].postId)
            cell.post = viewData.posts[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presenter = DetailViewControllerPresenter(webService: .init())
        let detailViewController = DetailViewController(presenter: presenter)
        if indexPath.section == MainSections.posts.rawValue {
            detailViewController.setData(post: viewData.posts[indexPath.row])
        } else {
            let postId = Int(self.presenter.getFavorites()[indexPath.row].postId)
            if let post = viewData.posts.first(where: { $0.postId == postId }) {
                detailViewController.setData(post: post)
            }
        }
        presenter.view = detailViewController
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == MainSections.favorites.rawValue ? false : true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewData.posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - MainViewTableViewCellDelegate
    
    func userDidSelectFavorite(postId: Int, isFavorite: Bool) {
        presenter.updateFavorite(postId: postId, isFavorite: isFavorite)
        tableView.reloadData()
    }
}

