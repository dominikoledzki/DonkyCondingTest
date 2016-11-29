//
//  Model.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import RealmSwift
import URITemplate

class Repo: Object {
    dynamic var id: Int64 = 0
    dynamic var name: String?
    dynamic var language: String?
    
    dynamic var commits_url: String?
    dynamic var releases_url: String?
    dynamic var html_url: String?
    
    let commits = List<Commit>()
    
    var commitsUrl: URL {
        let string = URITemplate(template: commits_url!).expand([String : Any]())
        let url = URL(string: string)!
        return url
    }
    
    var releasesUrl: URL {
        let string = URITemplate(template: releases_url!).expand([String : Any]())
        let url = URL(string: string)!
        return url
    }
    
    var htmlUrl: URL {
        return URL(string: html_url!)!
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Commit: Object {
    dynamic var sha = ""
    dynamic var commiterName = ""
    dynamic var avatarUrl: String?
    dynamic var date: Date?
    dynamic var message: String?
    
    override static func primaryKey() -> String? {
        return "sha"
    }
    
    static func constructor(json: Any) -> Commit {
        let dict = json as! Dictionary<String, Any>
        let commit = Commit()
        commit.sha = dict["sha"] as! String
        
        if let commiter = dict["committer"] as? Dictionary<String, Any> {
            commit.avatarUrl = commiter["avatar_url"] as? String
        }
        
        let commitDict = dict["commit"] as! Dictionary<String, Any>
        let commitCommitterDict = commitDict["committer"] as! Dictionary<String, Any>
        let dateStr = commitCommitterDict["date"] as! String
        commit.commiterName = commitCommitterDict["name"] as! String
        commit.date = ISO8601DateFormatter.shared.date(from: dateStr)
        
        commit.message = commitDict["message"] as? String
        
        return commit
    }
}

class Release {
    
}

class Model {
    let realm: Realm
    
    init() {
        let configuration = Realm.Configuration(inMemoryIdentifier: "DefaultInMemoryRealm")
        realm = try! Realm(configuration: configuration)
    }
}
