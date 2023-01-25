//
//  MainNavigationViewController.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let presenter = MainViewControllerPresenter(webService: .init(), coreDataHelper: .init())
        let mainViewController = MainViewController(presenter: presenter)
        presenter.view = mainViewController
        pushViewController(mainViewController, animated: false)
    }
}
