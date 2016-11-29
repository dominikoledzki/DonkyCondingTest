//
//  CommitTableViewCell.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 28/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
    static let identifier = String(describing: CommitTableViewCell.self)
    static let nib = UINib(nibName: "CommitTableViewCell", bundle: Bundle(for: CommitTableViewCell.self))
    static let estimatedRowHeight: CGFloat = 130.0
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .short
        df.dateStyle = .short
        return df
    }()
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commitMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width * 0.5
    }
    
    func setup(with commit: Commit) {
        userNameLabel.text = commit.commiterName
        commitMessageLabel.text = commit.message
        if let date = commit.date {
            dateLabel.text = CommitTableViewCell.dateFormatter.string(from: date)
        } else {
            dateLabel.text = nil
        }
    }
}
