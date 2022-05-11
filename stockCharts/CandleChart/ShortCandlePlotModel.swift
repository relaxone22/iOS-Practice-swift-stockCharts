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
    var frameHight: CGFloat = 300
    
    var viewMinYGap: CGFloat = 15
    
    var priceUnit: CGFloat = 0.1
    var volUnit: CGFloat = 0
    
    var maxPrice: CGFloat = CGFloat.leastNormalMagnitude
    var minPrice: CGFloat = CGFloat.greatestFiniteMagnitude
    var maxVol: CGFloat = CGFloat.leastNormalMagnitude
    
    var theme = ShortCandlePlotTheme()
    
    var topChartHeight: CGFloat {
        return theme.topChartScale * frameHight
    }
    
    var bottomChartHeight: CGFloat {
        return  (1 - theme.topChartScale) * frameHight - theme.xAxisHeight
        
    }
    
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
    
    var startX: CGFloat {
        let scrollViewOffsetX = contentOffsetX < 0 ? 0 : contentOffsetX
        return scrollViewOffsetX
    }
    
    var showCandleCount: Int {
        return Int(renderWidth / ( theme.candleWidth + theme.candleGap))
    }
    
    // 最初資料
    private var rawTicks:[Tick] = []
    // k線
    private var candlePositions:[CandlePosition] = []
    // 量
    private var volPositions:[VolPosition] = []
    
    func updateTick(ticks:[Tick]) {
        rawTicks = ticks
    }
    
    func clacMaxMinTicks() {
        guard rawTicks.count > 0 else { return }
        
        let count = min(startIndex + showCandleCount, rawTicks.count)
        for index in startIndex ..< count {
            let raw = rawTicks[index]
            
            maxPrice = max(maxPrice, raw.high.cgFloatValue)
            minPrice = min(minPrice, raw.low.cgFloatValue)
            maxVol = max(maxVol, raw.vol.cgFloatValue)
        }
    }
    
    func convertToPositions() {
        candlePositions.removeAll()
        volPositions.removeAll()
        
        let minY = viewMinYGap
        let maxDiff = maxPrice - minPrice
        
        if maxDiff > 0, maxVol > 0 {
            priceUnit = (topChartHeight - 2 * minY) / maxDiff
            volUnit = (bottomChartHeight - 2 * theme.volGap) / maxVol
        }
        
        let count = min(startIndex + showCandleCount, rawTicks.count)
        for index in startIndex ..< count {
            let raw = rawTicks[index]
            
            let pointLeft = startX + CGFloat(index - startIndex) * (theme.candleWidth + theme.candleGap)
            let pointX = pointLeft + theme.candleWidth / 2.0
            
            let highPoint = CGPoint(x: pointX, y: (maxPrice - raw.high.cgFloatValue) * priceUnit + minY)
            let lowPoint = CGPoint(x: pointX, y: (maxPrice - raw.low.cgFloatValue) * priceUnit + minY)
            
            let pointOpenY = (maxPrice - raw.open.cgFloatValue) * priceUnit + minY
            let pointCloseY = (maxPrice - raw.close.cgFloatValue) * priceUnit + minY
            
            var fillCandleColor = theme.defaultColor
            var candleRect = CGRect.zero
            
            
            var rectHieght = theme.candleMinHight
            var rectY = pointCloseY
            
            let diff = pointCloseY - pointOpenY
            if (diff > 0) {
                fillCandleColor = theme.riseColor
                rectY = pointCloseY
                rectHieght = abs(pointOpenY - pointCloseY)
            }
            else if (diff < 0) {
                fillCandleColor = theme.fallColor
                rectY = pointOpenY
                rectHieght = abs(pointOpenY - pointCloseY)
            }
            candleRect = CGRect(x: pointLeft, y: rectY, width: theme.candleWidth, height: rectHieght)
            
            let candele = CandlePosition(high: highPoint, low: lowPoint, rect: candleRect, color: fillCandleColor)
            candlePositions.append(candele)
            
            let vol = raw.vol.cgFloatValue * volUnit
            let volStartPoint = CGPoint(x: pointX, y: frameHight - vol)
            let volEndPoint = CGPoint(x: pointX, y: vol)
            
            let volPoint = VolPosition(volStartPoint: volStartPoint, volEndPoint: volEndPoint, color: fillCandleColor)
            volPositions.append(volPoint)
        }
    }
}

private extension String {
    var cgFloatValue: CGFloat {
        guard let doubleValue = Double(self) else { return 0 }
        return CGFloat(doubleValue)
    }
}
