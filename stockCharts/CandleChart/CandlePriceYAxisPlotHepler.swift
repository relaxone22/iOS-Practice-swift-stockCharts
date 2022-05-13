//
//  CandlePriceYAxisPlotHepler.swift
//  stockCharts
//
//  Created by Tony Liu on 2022/5/13.
//  Copyright © 2022 mitake. All rights reserved.
//

import Foundation
import UIKit

private struct PriceYAxisPosition {
    var priceY: CGPoint = .zero
    var priceString: String = ""
}

class CandlePriceYAxisPlotHepler: CandleUnitPlotHelper {
    var plotType: PlotType {
        return .PriceYAxis
    }
    
    var plotlayer: CAShapeLayer {
        convertToPositions()
        let layer = drawPriceYAxisLayer()
        return layer
    }
    
    private var positions: [PriceYAxisPosition] = []
    private var store: CandlePlotStore
    private var theme:CandlePlotTheme {
        return store.theme
    }
    
    init(store:CandlePlotStore) {
        self.store = store
    }
    
    private func drawPriceYAxisLayer() -> CAShapeLayer {
        let yAxisLayer = CAShapeLayer()
        
        for position in positions {
            let path = UIBezierPath()
            path.move(to: position.priceY)
            let endPoint = CGPoint(x: position.priceY.x + store.renderWidth, y: position.priceY.y)
            path.addLine(to: endPoint)
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.lineWidth = 1
            lineLayer.strokeColor = theme.priceYAxisLineColor.cgColor
            lineLayer.fillColor = theme.priceYAxisLineColor.cgColor
            yAxisLayer.addSublayer(lineLayer)
            
            let textLayer = CATextLayer()
            textLayer.string = position.priceString
            textLayer.fontSize = theme.priceYAxisFontSize
            textLayer.foregroundColor = theme.priceYAxisTextColor.cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.alignmentMode = kCAAlignmentCenter
            textLayer.contentsScale = UIScreen.main.scale
            
            let textSize = position.priceString.getTextSize(size: theme.priceYAxisFontSize)
            let textX = endPoint.x - textSize.width
            let texty = endPoint.y
            let textWidth = textSize.width
            let textHeight = textSize.height
            
            let textFarme = CGRect(x: textX, y: texty, width: textWidth, height: textHeight)
            textLayer.frame = textFarme
            
            yAxisLayer.addSublayer(textLayer)
        }
        return yAxisLayer
    }
    
    private func convertToPositions() {
        positions.removeAll()
        
        let minY = theme.viewMinYGap
        
        
        let pointYs:[CGFloat] = [1,
                                 minY,
                                 store.topChartHeight / 2,
                                 store.topChartHeight - minY,
                                 store.topChartHeight]
        let midPrice = String(format: ".2%f", (store.maxPrice - store.minPrice))
        let priceStrings = ["",
                            "\(store.minPrice)",
                            midPrice,
                            "\(store.maxPrice)",
                            ""]
        
        for (index, pointY) in pointYs.enumerated() {
            let point = CGPoint(x: store.startX, y: pointY)
            let position = PriceYAxisPosition(priceY: point, priceString: priceStrings[index])
            positions.append(position)
        }
    }
    
    
    
}
