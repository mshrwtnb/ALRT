//
//  DemoUITests.swift
//  DemoUITests
//
//  Created by Masahiro Watanabe on 2016/12/17.
//  Copyright © 2016 Masahiro Watanabe. All rights reserved.
//

import XCTest

class DemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlert(){
        let app = XCUIApplication()
        app.buttons["alert"].tap()
        
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(app.buttons["OK"].exists)
        XCTAssertTrue(app.buttons["No Way!"].exists)
        
        app.buttons["OK"].tap()
    }
    
    func testActionSheet(){
        let app = XCUIApplication()
        app.buttons["actionSheet"].tap()
        
        let sheet = app.sheets["Destination"]
        XCTAssertTrue(sheet.exists)
        
        let destinations = ["New York", "Paris", "London", "Not interested"]
        
        destinations.forEach {
            XCTAssertTrue(app.buttons[$0].exists)
        }
        
        app.buttons["Not interested"].tap()
    }
    
    func testAlertWithTextFields(){
        let app = XCUIApplication()
        app.buttons["login"].tap()
        
        let alert = app.alerts["Login"]
        XCTAssertTrue(alert.exists)
        
        let userNameTextField = alert.textFields["Username"]
        let passwordTextField = alert.secureTextFields["Password"]
        
        XCTAssertTrue(userNameTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        
        let userName = "johnappleseed"
        let password = "PL~TLasJL+)Pj24i3do"
        let securedPassword = (0..<password.characters.count).map({ _ in "•" }).joined()
        
        userNameTextField.tap()
        userNameTextField.typeText(userName)
        
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        XCTAssertEqual(userNameTextField.value as! String, userName)
        XCTAssertEqual(passwordTextField.value as! String, securedPassword)
        
        alert.buttons["OK"].tap()
    }
}
