//
//  Model.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import Foundation

class Repo: JSONDecodable {
    var name: String
    
    var releases = Array<Release>()
    var commits = Array<Commit>()
    
    init() {
        name = ""
    }
    
    required init?(jsonObject: Any) {
        
    }
}

class Commit {
    
}

class Release {
    
}

class Model {
//    static let dataChangedNotification = Notification.Name(rawValue: "ModelDataChangedNotification")
    
    var repos = Array<Repo>()
}

class MockModel: Model {
    
    override init() {
        super.init()
        
        repos = [
            Repo(),
            Repo(),
            Repo()
        ]
    }
    
}
