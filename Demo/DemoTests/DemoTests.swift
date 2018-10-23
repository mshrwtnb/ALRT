//
//  DemoTests.swift
//  DemoTests
//
//  Created by Masahiro Watanabe on 2018/10/23.
//  Copyright © 2018 Masahiro Watanabe. All rights reserved.
//

import XCTest
@testable import Demo

class DemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewController() {
        let exepecation = self.expectation(description: "wait for ALRT")
        
        let test = TestViewController()
        
        test.showALRT { (result) in
            self.inspect(result)
            exepecation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3.0, handler: nil)
    }

    func testPresentedViewController() {
        let exepecation = self.expectation(description: "wait for ALRT")
        
        let first = TestViewController()
        let second = TestViewController()
        first.present(second, animated: false)
        
        second.showALRT { (result) in
            self.inspect(result)
            exepecation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testViewControllerEmbeddedInNavigationController() {
        let exepecation = self.expectation(description: "wait for ALRT")
        
        let test = TestViewController()
        _ = test.embedInNavigationController()
        
        test.showALRT { (result) in
            self.inspect(result)
            exepecation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testPushedViewController() {
        let exepecation = self.expectation(description: "wait for ALRT")
        
        let first = TestViewController().embedInNavigationController()
        let second = TestViewController()
        first.pushViewController(second, animated: true)
        
        second.showALRT { (result) in
            self.inspect(result)
            exepecation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func inspect(_ result: ALRT.Result) {
        if case .success = result {
            XCTAssertTrue(true)
        } else {
            XCTFail()
        }
    }
}

class TestViewController: UIViewController {
    func showALRT(_ completionHandler: @escaping (ALRT.Result) -> Void) {
        ALRT.create(.alert, title: "Unit Test Alert").addOK().show() {
            completionHandler($0)
        }
    }
}

extension TestViewController {
    func embedInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
