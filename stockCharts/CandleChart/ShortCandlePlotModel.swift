//
//  ShortCandlePlotModel.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/11.
//  Copyright © 2022 mitake. All rights reserved.
//

import Foundation
import UIKit

class ShortCandlePlotModel {
    
    var contentOffsetX:CGFloat = 0
    var renderWidth: CGFloat = 0
    
    var maxPrice: CGFloat = 0
    var minPrice: CGFloat = 0
    var maxVol: CGFloat = 0
    
    var theme = ShortCandlePlotTheme()
    
    var startIndex: Int {
        
        let scrollViewOffsetX = max(contentOffsetX, 0)
        let leftCandleCount = Int(scrollViewOffsetX / (theme.candleWidth + theme.candleGap))
        
        let value = leftCandleCount - rawTicks.count
        
        if value == 0 {
            return leftCandleCount
        }
        else {
            let subtraction = (value > 0) ? -1 : 1
            return leftCandleCount + subtraction
        }
    }
    
    var showCandleCount: Int {
        return Int(renderWidth / ( theme.candleWidth + theme.candleGap))
        
    }
    
    // 最初資料
    private var rawTicks:[Tick] = []
    
    func updateTick(ticks:[Tick]) {
        rawTicks = ticks
    }
    
    func clacMaxMinTicks() {
        guard rawTicks.count > 0 else {
            return
        }
        
        let count = min(startIndex + showCandleCount, rawTicks.count)
        
        for index in count
    }
    
    
}
