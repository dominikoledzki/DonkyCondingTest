//
//  RepoTableViewCell.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    static let identifier = String(describing: RepoTableViewCell.self)
    static let nib = UINib(nibName: "RepoTableViewCell", bundle: Bundle(for: RepoTableViewCell.self))
    static let estimatedRowHeight: CGFloat = 67.0
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(with repo: Repo) {
        nameLabel.text = repo.name
    }
}
