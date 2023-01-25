//
//  DetailViewTableViewCell.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 25/01/2023.
//

import UIKit

class DetailViewTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    func populate(comment: Comment) {
        nameLabel.text = comment.name
        emailLabel.text = comment.email
        bodyLabel.text = comment.body
    }
}
