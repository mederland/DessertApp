//
//  DessertAppUITests.swift
//  DessertAppUITests
//
//  Created by Meder iZimov on 1/8/23.
//

import XCTest

final class DessertAppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            iOS 16.2
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

