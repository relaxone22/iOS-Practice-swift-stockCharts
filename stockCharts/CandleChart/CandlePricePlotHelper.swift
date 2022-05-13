//
//  ShortCandlePlotTheme.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/11.
//  Copyright © 2022 mitake. All rights reserved.
//

import Foundation
import UIKit

private struct CandlePosition {
    var high: CGPoint = .zero
    var low: CGPoint = .zero
    var rect: CGRect = .zero
    var color: UIColor = .yellow
}

class CandlePricePlotHelper: CandleUnitPlotHelper {
    var plotType: PlotType {
        return .Price
    }
    
    var plotlayer: CAShapeLayer {
        convertToPositions()
        let layer = drawCandleLayer()
        return layer
    }
    
    // k線
    private var positions:[CandlePosition] = []
    private var priceUnit: CGFloat = 0.1
    private var store: CandlePlotStore
    
    private var theme:CandlePlotTheme {
        return store.theme
    }
    
    init(store:CandlePlotStore) {
        self.store = store
    }
    
    private func drawCandleLayer() -> CAShapeLayer {
        let candlePriceLayer = CAShapeLayer()
        
        for position in positions {
            let path = UIBezierPath(rect: position.rect)
            path.move(to: position.low)
            path.addLine(to: position.high)
            
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.strokeColor = position.color.cgColor
            layer.fillColor = position.color.cgColor
            
            candlePriceLayer.addSublayer(layer)
        }
        return candlePriceLayer
    }
    
    private func convertToPositions() {
        positions.removeAll()
        
        let minY = theme.viewMinYGap
        let maxDiff = store.maxPrice - store.minPrice
        
        if maxDiff > 0 {
            priceUnit = (store.topChartHeight - 2 * minY) / maxDiff
        }
        
        let count = min(store.startIndex + store.showCandleCount, store.rawTicks.count)
        for index in store.startIndex ..< count {
            let raw = store.rawTicks[index]
            
            let pointLeft = store.startX + CGFloat(index - store.startIndex) * (theme.candleWidth + theme.candleGap)
            let pointX = pointLeft + theme.candleWidth / 2.0
            
            let highPoint = CGPoint(x: pointX, y: (store.maxPrice - raw.high.cgFloatValue) * priceUnit + minY)
            let lowPoint = CGPoint(x: pointX, y: (store.maxPrice - raw.low.cgFloatValue) * priceUnit + minY)
            
            let pointOpenY = (store.maxPrice - raw.open.cgFloatValue) * priceUnit + minY
            let pointCloseY = (store.maxPrice - raw.close.cgFloatValue) * priceUnit + minY
            
            var fillCandleColor = theme.defaultColor
            var candleRect = CGRect.zero
            
            
            var rectHieght = theme.candleMinHight
            var rectY = pointCloseY
            
            let diff = raw.close.cgFloatValue - raw.open.cgFloatValue
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
            positions.append(candele)
        }
    }
}
