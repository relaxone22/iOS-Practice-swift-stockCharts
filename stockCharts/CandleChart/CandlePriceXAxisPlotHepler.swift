//
//  CandlePlotHepler.swift
//  stockCharts
//
//  Created by Tony Liu on 2022/5/13.
//  Copyright © 2022 mitake. All rights reserved.
//

import Foundation
import UIKit

private struct PriceXAxisPosition {
    var timeX: CGPoint = .zero
    var dateString: String = ""
}

class CandlePriceXAxisPlotHepler: CandleUnitPlotHelper {
    var plotType: PlotType {
        return .PriceXAxis
    }
    
    var plotlayer: CAShapeLayer {
        convertToPositions()
        let layer = drawPriceXAxisLayer()
        return layer
    }
    
    private var positions: [PriceXAxisPosition] = []
    private var store: CandlePlotStore
    private var theme:CandlePlotTheme {
        return store.theme
    }
    
    init(store:CandlePlotStore) {
        self.store = store
    }
    
    private func drawPriceXAxisLayer() -> CAShapeLayer {
        let xAxisLayer = CAShapeLayer()
        
        for position in positions {
            let path = UIBezierPath()
            path.move(to: position.timeX)
            let endPoint = CGPoint(x: position.timeX.x, y: store.topChartHeight + theme.viewMinYGap * 2)
            path.addLine(to: endPoint)
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.lineWidth = 1
            lineLayer.strokeColor = theme.timeXAxisLineColor.cgColor
            lineLayer.fillColor = theme.timeXAxisLineColor.cgColor
            xAxisLayer.addSublayer(lineLayer)
        
            let textLayer = CATextLayer()
            textLayer.string = position.dateString
            textLayer.fontSize = theme.timeXAxisFontSize
            textLayer.foregroundColor = theme.timeXAxisTextColor.cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.alignmentMode = kCAAlignmentCenter
            textLayer.contentsScale = UIScreen.main.scale
            
            let textSize = position.dateString.getTextSize(size: theme.timeXAxisFontSize)
            let textX = position.timeX.x - textSize.width / 2
            let texty = endPoint.y
            let textWidth = textSize.width
            let textHeight = textSize.height
            
            let textFarme = CGRect(x: textX, y: texty, width: textWidth, height: textHeight)
            textLayer.frame = textFarme
            
            xAxisLayer.addSublayer(textLayer)
        }
        
        return xAxisLayer
    }
    
    private func convertToPositions() {
        positions.removeAll()
        
        let count = min(store.startIndex + store.showCandleCount, store.rawTicks.count)
        for index in store.startIndex ..< count {
            
            let raw = store.rawTicks[index]
            
            if index % store.priceXAxisIndexGap == 0 {
                
                let pointLeft = store.startX + CGFloat(index - store.startIndex) * (theme.candleWidth + theme.candleGap)
                let pointX = pointLeft + theme.candleWidth / 2.0
                
                let label = raw.date
                let point = CGPoint(x: pointX, y: 0)
                
                let position = PriceXAxisPosition(timeX: point, dateString: label)
                positions.append(position)
            }
            
        }
    }
}
