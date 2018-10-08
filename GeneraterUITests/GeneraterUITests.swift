//
//  GeneraterUITests.swift
//  GeneraterUITests
//
//  Created by Aisha on 5/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import XCTest

class GeneraterUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
        func testTextfeild(){
            
            let app = XCUIApplication()
            app.textFields["Enter here"].tap()
            app.buttons["circled play"].tap()
            
            let tabBarsQuery = app.tabBars
            let historyButton = tabBarsQuery.buttons["History"]
            historyButton.tap()
            
            let generatorButton = tabBarsQuery.buttons["Generator"]
            generatorButton.tap()
            historyButton.tap()
            generatorButton.tap()
            historyButton.tap()
            generatorButton.tap()
            generatorButton.tap()
            historyButton.tap()
            generatorButton.tap()
            
    }
    
   
    func testCirclesfeild(){
        
        let app = XCUIApplication()
        app.textFields["Enter here"].tap()
        app.buttons["circled play"].tap()
        app.tabBars.buttons["History"].tap()
        XCUIApplication().tabBars.buttons["Generator"].tap()
         XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element.tap()
    }
}
