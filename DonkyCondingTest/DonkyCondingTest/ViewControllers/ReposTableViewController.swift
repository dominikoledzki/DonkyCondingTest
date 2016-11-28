//
//  ReposTableViewController.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    private let model: Model
    
    init(model: Model) {
        self.model = model
        super.init(style: .plain)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "repos.title".localized
        clearsSelectionOnViewWillAppear = true
        tableView.register(RepoTableViewCell.nib, forCellReuseIdentifier: RepoTableViewCell.identifier)
        tableView.estimatedRowHeight = RepoTableViewCell.estimatedRowHeight
        
        reloadData()
    }
    
    private func reloadData() {
        Services(model: model).fetchRepos { (error) in
            print(error)
        }
    }
    
    // MARK: Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.identifier, for: indexPath) as! RepoTableViewCell
        let repo = model.repos[indexPath.item]
        cell.setup(with: repo)
        return cell
    }
    
    // MARK: Others
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
