//
//  stockChartsTests.swift
//  stockChartsTests
//
//  Created by TDCC_IFD on 2022/5/18.
//  Copyright © 2022 mitake. All rights reserved.
//

import XCTest
@testable import stockCharts

class MockView:CandlePlotStoreDelegate {
    var contentOffsetX:CGFloat {
        return 10;
    }
    var renderWidth: CGFloat {
        return 400
    }
    var frameHight: CGFloat {
        return 600
    }
}

class stockChartsTests: XCTestCase {
    
    let service = CandleDataService.shared
    let mockView = MockView()
    
    override func setUpWithError() throws {
       
        service.loadData()
    }

    override func tearDownWithError() throws {
        
    }

    func testPricePositions() throws {
        let ticks = service.list!.ticks
        
        let store = CandlePlotStore()
        store.delegate = mockView
        store.updateTick(ticks: ticks)
        let helper = PlotType.Price.getLayerHelper(store)
        let testLayer = helper?.plotlayer
        
        XCTAssert(testLayer?.sublayers?.count ?? 0 > 0)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            guard let ticks = service.list?.ticks else {
                return
            }
            let store = CandlePlotStore()
            store.updateTick(ticks: ticks)
            let helper = PlotType.Price.getLayerHelper(store)
            let _ = helper?.plotlayer
        }
    }

}
