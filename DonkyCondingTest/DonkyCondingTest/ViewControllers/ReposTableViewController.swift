//
//  ReposTableViewController.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit
import RealmSwift

protocol ReposTableViewControllerDelegate: class {
    func reposTableViewController(_ vc: ReposTableViewController, didSelect repo: Repo)
}

class ReposTableViewController: UITableViewController {
    private let model: Model
    private let services: Services
    private let repos: Results<Repo>
    private var notificationToken: NotificationToken?
    private let errorView: ErrorTableViewHeader = {
        let v = ErrorTableViewHeader.fromNib()
        v.label.text = "general.networkError".localized
        return v
    }()
    private var shouldShowError = false
    
    weak var delegate: ReposTableViewControllerDelegate?
    
    deinit {
        notificationToken?.stop()
    }
    
    init(model: Model, services: Services) {
        self.model = model
        self.services = services
        repos = model.realm.objects(Repo.self).sorted(byProperty: "name")
        super.init(style: .plain)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "repos.title".localized
        clearsSelectionOnViewWillAppear = true
        tableView.register(RepoTableViewCell.nib, forCellReuseIdentifier: RepoTableViewCell.identifier)
        tableView.estimatedRowHeight = RepoTableViewCell.estimatedRowHeight
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshData()
        
        notificationToken = repos.addNotificationBlock({ (changes) in
            self.tableView.reloadData()
        })
    }
    
    @objc private func refreshData() {
        let activityIndicator = ActivityIndicatorView.show(on: tableView, in: view)
        
        services.fetchRepos { (repos, error) in
            
            if let repos = repos {
                try! self.model.realm.write {
                    self.model.realm.deleteAll()
                    self.model.realm.add(repos, update: true)
                }
                self.hideNetworkError()
            } else {
                self.showNetworkError()
            }
            
            activityIndicator.hide()
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: Error view
    private func showNetworkError() {
        shouldShowError = true
        tableView.reloadData()
    }
    
    private func hideNetworkError() {
        shouldShowError = false
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.identifier, for: indexPath) as! RepoTableViewCell
        let repo = repos[indexPath.item]
        cell.setup(with: repo)
        return cell
    }
    
    // MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if shouldShowError {
            return errorView
        } else {
            return super.tableView(tableView, viewForHeaderInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return shouldShowError ? UITableViewAutomaticDimension : 0.0
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return shouldShowError ? ErrorTableViewHeader.estimatedHeight : 0.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos[indexPath.item]
        delegate?.reposTableViewController(self, didSelect: repo)
    }
    
    // MARK: Others
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
