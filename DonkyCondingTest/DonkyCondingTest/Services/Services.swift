//
//  Services.swift
//  DonkyCondingTest
//
//  Created by Dominik Olędzki on 28/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import Foundation
import URITemplate

class Services {
    typealias FetchCompletionHandler = (Error?) -> Void
    let errorDomain = "ServicesErrorDomain"
    enum ErrorCode: Int {
        case InvalidResponse = 1
        case ResponseUnsuccessful
        case NoData
    }
    
    private let urlSession: URLSession
    private unowned let model: Model
    
    private let organisation = "Donky-Network"
    private let reposApiTemplate = URITemplate(template: "https://api.github.com/orgs/{org}/repos")
    
    init(model: Model) {
        self.model = model
        
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let bundleVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        let userAgent = appName + " " + appVersion + "b" + bundleVersion
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "User-Agent": userAgent
        ]
        
        urlSession = URLSession(configuration: configuration)
    }
    
    func fetchRepos(completionHandler: FetchCompletionHandler?) {
        let url = URL(string: reposApiTemplate.expand(["org": organisation]))!
        let request = URLRequest(url: url)
        
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
                let repos = Repo.decodeArray(jsonObject: jsonObject)
                
            } catch {
                completionHandler?(error)
            }
        }).resume()
    }
    
}
