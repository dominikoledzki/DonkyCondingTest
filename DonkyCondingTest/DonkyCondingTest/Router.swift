//
//  Router.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class Router {
    private let model: Model
    
    private let keyWindow = UIWindow(frame: UIScreen.main.bounds)
    private let rootNavController = UINavigationController()
    private let reposViewController: ReposTableViewController
    
    init(model: Model) {
        self.model = model
        self.reposViewController = ReposTableViewController(model: model)
    }
    
    func prepareTheApp() {
        keyWindow.rootViewController = rootNavController
        rootNavController.pushViewController(reposViewController, animated: false)
        keyWindow.makeKeyAndVisible()
    }
}
