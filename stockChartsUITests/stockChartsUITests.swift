//
//  stockChartsUITests.swift
//  stockChartsUITests
//
//  Created by TDCC_IFD on 2022/5/18.
//  Copyright © 2022 mitake. All rights reserved.
//

import XCTest

class stockChartsUITests: XCTestCase {
    
    let app = XCUIApplication()
    var tableView: XCUIElement!
    
    override func setUp() {
        
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
        
        
        app.launch()
    }
    
    func testShowCandlePlot() throws {
        
        
        
        tableView = app.tables["mytable"]
        let cell = tableView.cells.containing(.cell, identifier: "k線圖")
        cell.element.tap()
        
        let element = app.scrollViews.children(matching: .other).element(boundBy: 0)
        if element.waitForExistence(timeout: 5) != true {
            XCTFail()
        }
        element.swipeLeft()
        takePhoto()
        element.swipeLeft()
        element.swipeRight()
        
        
        
        element.press(forDuration: 3)
        takePhoto()
        
//        let start = element.coordinate(withNormalizedOffset: CGVector(dx: 0.8, dy: 0.5))
//        start.press(forDuration: 3)
//        let finish = element.coordinate(withNormalizedOffset: CGVector(dx: 0.4, dy: 0.5))
//        finish.press(forDuration: 3)
//        finish.press(forDuration: 3, thenDragTo: start)
        
        element.swipeRight()
        
        app.navigationBars["k線圖"].buttons["Demo"].tap()
                
    }
    
    func takePhoto() {
        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(screenshot: fullScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
        
    }

    
}
