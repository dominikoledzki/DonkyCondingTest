//
//  CommitsTableViewController.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 28/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit
import RealmSwift

class CommitsTableViewController: UITableViewController {
    private let model: Model
    private let repo: Repo
    private let services: Services
    private var notificationToken: NotificationToken?
    
    deinit {
        notificationToken?.stop()
    }
    
    init(model: Model, repo: Repo, services: Services) {
        self.model = model
        self.repo = repo
        self.services = services
        
        super.init(style: .plain)
        title = "commits.title".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CommitTableViewCell.nib, forCellReuseIdentifier: CommitTableViewCell.identifier)
        tableView.estimatedRowHeight = CommitTableViewCell.estimatedRowHeight
     
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshData()
        
        notificationToken = repo.commits.addNotificationBlock({ (_) in
            self.tableView.reloadData()
        })
    }
    
    @objc private func refreshData() {
        services.fetchCommits(for: repo) {
            (commits, error) in
            
            if let commits = commits {
                try! self.model.realm.write {
                    self.model.realm.add(commits, update: true)
                    self.repo.commits.removeAll()
                    self.repo.commits.append(objectsIn: commits)
                }
            }
            
            self.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.commits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommitTableViewCell.identifier, for: indexPath) as! CommitTableViewCell
        let commit = repo.commits[indexPath.item]
        cell.setup(with: commit)
        return cell
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommitTableViewCell.estimatedRowHeight
    }
    
    // MARK: Other
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
