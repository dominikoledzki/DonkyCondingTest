//
//  Extensions.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIApplication {
    var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
    var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    var bundleVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
}

extension UIViewController {
    var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }
}

extension ISO8601DateFormatter {
    static let shared = ISO8601DateFormatter()
}

extension UILabel {
    @objc var localizedText: String? {
        set {
            text = localizedText?.localized
        }
        get {
            return text
        }
    }
}
