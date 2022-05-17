//
//  CandleVolPlotStore.swift
//  stockCharts
//
//  Created by Tony Liu on 2022/5/12.
//  Copyright © 2022 mitake. All rights reserved.
//

import Foundation
import UIKit

private struct VolPosition {
    var volStartPoint: CGPoint = .zero
    var volEndPoint: CGPoint = .zero
    var color: UIColor = .yellow
}

class CandleVolPlotHelper: CandleUnitPlotHelper {
    var plotType: PlotType {
        return .Vol
    }
    
    var plotlayer: CAShapeLayer {
        convertToPositions()
        let layer = drawVoleLayer()
        return layer
    }
    
    // 量
    private var positions:[VolPosition] = []
    private var volUnit: CGFloat = 0
    private var store: CandlePlotStore
    private var theme:CandlePlotTheme {
        return store.theme
    }
    
    init(store:CandlePlotStore) {
        self.store = store
    }
    
    private func drawVoleLayer() -> CAShapeLayer {
        let candlePriceLayer = CAShapeLayer()
        
        for position in positions {
            let path = UIBezierPath()
            path.move(to: position.volStartPoint)
            path.addLine(to: position.volEndPoint)
            
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.lineWidth = theme.candleWidth
            layer.strokeColor = position.color.cgColor
            layer.fillColor = position.color.cgColor
            
            candlePriceLayer.addSublayer(layer)
        }
        return candlePriceLayer
    }
    
    private func convertToPositions() {
        positions.removeAll()
        
        if store.maxVol > 0 {
            volUnit = (store.bottomChartHeight - 1 * theme.volGap) / store.maxVol
        }
        
        let count = min(store.startIndex + store.showCandleCount, store.rawTicks.count)
        for index in store.startIndex ..< count {
            let raw = store.rawTicks[index]
            
            let pointLeft = store.startX + CGFloat(index - store.startIndex) * (theme.candleWidth + theme.candleGap)
            let pointX = pointLeft + theme.candleWidth / 2.0
            
            var fillCandleColor = theme.defaultColor
            let diff = raw.close.cgFloatValue - raw.open.cgFloatValue
            if (diff > 0) {
                fillCandleColor = theme.riseColor
            }
            else if (diff < 0) {
                fillCandleColor = theme.fallColor
            }
   
            
            let vol = raw.vol.cgFloatValue * volUnit
            let volStartPoint = CGPoint(x: pointX, y: store.frameHight - vol)
            let volEndPoint = CGPoint(x: pointX, y: store.frameHight)
            
            let volPoint = VolPosition(volStartPoint: volStartPoint, volEndPoint: volEndPoint, color: fillCandleColor)
            positions.append(volPoint)
        }
    }
    
    func selectTickIndexPoint( tickIndex:Int) -> CGPoint {
        let raw = store.rawTicks[tickIndex]
        
        if store.maxVol > 0 {
            volUnit = (store.bottomChartHeight - 1 * theme.volGap) / store.maxVol
        }
        let vol = raw.vol.cgFloatValue * volUnit
        let pointY = store.frameHight - vol
        
        let pointLeft = store.startX + CGFloat(tickIndex - store.startIndex) * (theme.candleWidth + theme.candleGap)
        let pointX = pointLeft + theme.candleWidth / 2.0
        
        return CGPoint(x: pointX, y: pointY)
    }
}
