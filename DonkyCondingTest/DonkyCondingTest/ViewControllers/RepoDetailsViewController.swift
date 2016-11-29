//
//  RepoDetailsViewController.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 29/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {
    private let repo: Repo
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    init(repo: Repo) {
        self.repo = repo
        super.init(nibName: "RepoDetailsViewController", bundle: Bundle(for: RepoDetailsViewController.self))
        title = "details.title".localized
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        nameLabel.text = repo.name
        languageLabel.text = repo.language
        urlLabel.text = repo.html_url
    }
    
    @IBAction func onUrl(_ sender: UITapGestureRecognizer) {
        UIApplication.shared.open(repo.htmlUrl, options: [:], completionHandler: nil)

    }
}
