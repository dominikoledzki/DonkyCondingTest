//
//  Router.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
}

class Router {
    private let model: Model
    private let services: Services
    
    private let keyWindow = UIWindow(frame: UIScreen.main.bounds)
    private let rootNavController = RootNavigationController()
    private let reposViewController: ReposTableViewController
    
    init(model: Model, services: Services) {
        self.model = model
        self.services = services
        self.reposViewController = ReposTableViewController(model: model, services: services)
    }
    
    func prepareTheApp() {
        keyWindow.rootViewController = rootNavController
        rootNavController.pushViewController(reposViewController, animated: false)
        keyWindow.makeKeyAndVisible()

        reposViewController.delegate = self
    }
    
    fileprivate func show(repo: Repo) {
        let vc = RepoViewController(model: model, repo: repo, services: services)
        rootNavController.pushViewController(vc, animated: true)
    }
}

extension Router: ReposTableViewControllerDelegate {
    func reposTableViewController(_ vc: ReposTableViewController, didSelect repo: Repo) {
        show(repo: repo)
    }
}
