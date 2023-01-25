//
//  UIRefreshControl.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 25/01/2023.
//

import UIKit

extension UIRefreshControl {
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
        sendActions(for: .valueChanged)
    }
}
