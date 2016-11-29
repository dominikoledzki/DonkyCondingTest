//
//  AppDelegate.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var model: Model!
    var services: Services!
    var router: Router!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        model = Model()
        services = Services()
        router = Router(model: model, services: services)
        
        router.prepareTheApp()
        
        return true
    }
}

