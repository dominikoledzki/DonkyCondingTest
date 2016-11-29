//
//  RepoViewController.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 28/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class RepoViewController: SegmentedViewController {
    private let model: Model!
    private let repo: Repo!
    private let detailsVC: RepoDetailsViewController
    private let commitsVC: CommitsTableViewController
    private let releasesVC = ReleasesTableViewController()
    
    init(model: Model, repo: Repo, services: Services) {
        self.model = model
        self.repo = repo
        detailsVC = RepoDetailsViewController(repo: repo)
        commitsVC = CommitsTableViewController(model: model, repo: repo, services: services)
        let viewControllers: Array<UIViewController> = [detailsVC, commitsVC, releasesVC]
        super.init(viewControllers: viewControllers)
    }
        
    // MARK: Others
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
