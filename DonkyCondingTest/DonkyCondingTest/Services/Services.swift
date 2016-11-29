//
//  Services.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 28/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import Foundation
import URITemplate
import RealmSwift

class Services {
    let errorDomain = "ServicesErrorDomain"
    enum ErrorCode: Int {
        case InvalidResponse = 1
        case ResponseUnsuccessful
        case NoData
        case InvalidJSON
    }
    
    private let urlSession: URLSession
    private let organisation = "Donky-Network"
    private let reposApiTemplate = URITemplate(template: "https://api.github.com/orgs/{org}/repos")
    
    init() {
        let appName = UIApplication.shared.appName
        let appVersion = UIApplication.shared.appVersion
        let bundleVersion = UIApplication.shared.bundleVersion
        
        let userAgent = appName + " " + appVersion + "b" + bundleVersion
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.httpAdditionalHeaders = [
            "User-Agent": userAgent
        ]
        
        urlSession = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func fetchRepos(completionHandler: @escaping (Array<Repo>?, Error?) -> Void) {
        let url = URL(string: reposApiTemplate.expand(["org": organisation]))!
        let request = URLRequest(url: url)
        fetchArray(request: request, constructor: { Repo(value: $0) }, completionHandler: completionHandler)
    }
    
    func fetchCommits(for repo: Repo, completionHandler: @escaping (Array<Commit>?, Error?) -> Void) {
        let url = repo.commitsUrl
        let request = URLRequest(url: url)
        fetchArray(request: request, constructor: Commit.constructor, completionHandler: completionHandler)
    }
    
    private func fetchArray<T: Object>(request: URLRequest, constructor: @escaping (Any) -> T, completionHandler: @escaping (Array<T>?, Error?) -> Void) {
        urlSession.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            do {
                
                guard error == nil else {
                    throw error!
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NSError(domain: self.errorDomain, code: ErrorCode.InvalidResponse.rawValue, userInfo: nil)
                }
                
                guard let data = data else {
                    throw NSError(domain: self.errorDomain, code: ErrorCode.NoData.rawValue, userInfo: nil)
                }
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                guard let objectsArray = jsonObject as? Array<Any> else {
                    throw NSError(domain: self.errorDomain, code: ErrorCode.InvalidJSON.rawValue, userInfo: nil)
                }
                
                let objects = objectsArray.map { constructor($0) }
                completionHandler(objects, nil)
                
            } catch {
                completionHandler(nil, error)
            }
        }).resume()
    }
}
