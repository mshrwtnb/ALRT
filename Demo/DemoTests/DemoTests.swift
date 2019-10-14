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
        let expectation = self.expectation(description: "ALRT should be shown from view controller")

        let test = TestViewController()
        
        test.showALRT { (result) in
            self.inspect(result)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3.0, handler: nil)
    }

    func testPresentedViewController() {
        let expectation = self.expectation(description: "ALRT should be shown from presented view controller")
        
        let first = TestViewController()
        let second = TestViewController()
        first.present(second, animated: false)
        
        second.showALRT { (result) in
            self.inspect(result)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testViewControllerEmbeddedInNavigationController() {
        let expectation = self.expectation(description: "ALRT should be shown from view controller in UINavigationController")
        
        let test = TestViewController()
        _ = test.embedInNavigationController()
        
        test.showALRT { (result) in
            self.inspect(result)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testPushedViewController() {
        let expectation = self.expectation(description: "ALRT should be shown from pushed view controller")
        
        let first = TestViewController().embedInNavigationController()
        let second = TestViewController()
        first.pushViewController(second, animated: true)
        
        second.showALRT { (result) in
            self.inspect(result)
            expectation.fulfill()
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
