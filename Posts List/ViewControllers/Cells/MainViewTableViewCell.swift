//
//  MainViewTableViewCell.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import UIKit

protocol MainViewTableViewCellDelegate: AnyObject {
    func userDidSelectFavorite(postId: Int, isFavorite: Bool)
}

class MainViewTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    weak var delegate: MainViewTableViewCellDelegate?
    var isFavorite: Bool = false
    var post: Post? {
        didSet {
            titleLabel.text = post?.title
            isFavorite ? favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal) : favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @objc func buttonTapped(_ sender : Any) {
        if let postId = post?.postId {
            delegate?.userDidSelectFavorite(postId: postId, isFavorite: !isFavorite)
        }
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        if let postId = post?.postId {
            delegate?.userDidSelectFavorite(postId: postId, isFavorite: !isFavorite)
        }
    }
}
