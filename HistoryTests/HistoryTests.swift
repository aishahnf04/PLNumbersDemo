//
//  HistoryTests.swift
//  HistoryTests
//
//  Created by Aisha on 5/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import XCTest
@testable import PLDemo
class HistoryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func test_title_History() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appTabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
        let history = appTabBarController.viewControllers?.last as! HistoryViewController
        
        let _ = history.view
        //XCTAssertEqual("History1", history.navigationItem.title!)
    }
    func testLabel() {
        
    }
}
