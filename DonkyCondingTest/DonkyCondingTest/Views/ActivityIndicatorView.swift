//
//  ActivityIndicatorView.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 29/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    init() {
        super.init(frame: UIScreen.main.bounds)
        activityIndicator.color = UIColor.darkGray
        backgroundColor = UIColor.white
        
        addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
        activityIndicator.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func show(on onView: UIView, in inView: UIView) -> ActivityIndicatorView {
        let frame = onView.convert(onView.bounds, to: inView)
        let ai = ActivityIndicatorView()
        ai.frame = frame
        inView.addSubview(ai)
        ai.activityIndicator.startAnimating()
        return ai
    }

    func hide() {
        activityIndicator.stopAnimating()
        removeFromSuperview()
    }
}
