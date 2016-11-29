//
//  ErrorTableViewHeader.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 29/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class ErrorTableViewHeader: UIView {
    static let estimatedHeight: CGFloat = 45.0
    @IBOutlet weak var label: UILabel!
    
    static func fromNib() -> ErrorTableViewHeader {
        let nib = UINib(nibName: "ErrorTableViewHeader", bundle: Bundle(for: ErrorTableViewHeader.self))
        let view = nib.instantiate(withOwner: nil, options: nil).first
        return view as! ErrorTableViewHeader
    }
}
