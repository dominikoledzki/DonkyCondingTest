//
//  DonkyCondingTestTests.swift
//  DonkyCondingTestTests
//
//  Created by Dominik Olędzki on 27/11/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import XCTest
import URITemplate

class DonkyCondingTestTests: XCTestCase {
    
    func testURITemplate() {
        let templateString = "https://api.github.com/repos/Donky-Network/DonkySDK-Android-Modular/releases{/id}"
        let template = URITemplate(template: templateString)
        XCTAssertEqual(template.expand(["id" : "123"]), "https://api.github.com/repos/Donky-Network/DonkySDK-Android-Modular/releases/123")
        XCTAssertEqual(template.expand([String : Any]()), "https://api.github.com/repos/Donky-Network/DonkySDK-Android-Modular/releases")
        
    }
    
}
