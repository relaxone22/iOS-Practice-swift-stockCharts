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
        
        tableView = app.tables["mytable"]
        app.launch()
    }
    
    func testShowCandlePlot() throws {
        
        let cell = tableView.cells.containing(.cell, identifier: "k線圖")
        cell.element.tap()
        
        let element = app.scrollViews.children(matching: .other).element(boundBy: 0)
        element.swipeLeft()
        element.swipeLeft()
        element.swipeRight()
        element.swipeRight()
        element/*@START_MENU_TOKEN@*/.press(forDuration: 3.7);/*[[".tap()",".press(forDuration: 3.7);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
    }

    
}
