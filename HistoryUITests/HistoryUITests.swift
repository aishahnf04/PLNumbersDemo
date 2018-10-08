//
//  HistoryUITests.swift
//  HistoryUITests
//
//  Created by Aisha on 5/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import XCTest

class HistoryUITests: XCTestCase {

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
    
       func testTabs() {
    
    let app = XCUIApplication()
    let tabBarsQuery = app.tabBars
    tabBarsQuery.buttons["History"].tap()
    tabBarsQuery.buttons["Generator"].tap()
    
    }
    
    func testSelection() {
         let app = XCUIApplication()
        let circledPlayButton = app.buttons["circled play"]
        circledPlayButton.tap()
        app.alerts["Enter Number"].buttons["OK"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        circledPlayButton.tap()
    }
    
    
    func testLabel() {
        let app = XCUIApplication()
        let button = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element
        button.tap()
        app.alerts["Enter Number"].buttons["OK"].tap()
        app.textFields["Enter here"].tap()
        button.tap()
        
        let tabBarsQuery = app.tabBars
        let historyButton = tabBarsQuery.buttons["History"]
        historyButton.tap()
        tabBarsQuery.buttons["Generator"].tap()
        historyButton.tap()
    }
    
    func testHistoryData()
    {
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.tabBars.buttons["History"].tap()
        
        let cellsQuery = app.tables.cells.containing(.staticText, identifier:"1,4,5,3,2,")
        cellsQuery.children(matching: .other).element(boundBy: 9).tap()
                cellsQuery.children(matching: .other).element(boundBy: 8).tap()
    }
}
