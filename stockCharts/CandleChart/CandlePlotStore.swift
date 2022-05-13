//
//  ShortCandlePlotModel.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/11.
//  Copyright © 2022 mitake. All rights reserved.
//

import Foundation
import UIKit

protocol CandleUnitPlotHelper {
    var plotType:PlotType { get }
    var plotlayer:CAShapeLayer { get }
}

enum PlotType {
    case Price
    case PriceXAxis
    case PriceYAxis
    case Vol
    
    func getLayerHelper(_ store: CandlePlotStore) -> CandleUnitPlotHelper? {
        switch self {
        case .Price:
            return CandlePricePlotHelper(store: store)
        case .Vol:
            return CandleVolPlotHelper(store: store)
        case .PriceXAxis:
            return CandlePriceXAxisPlotHepler(store: store)
        case .PriceYAxis:
            return CandlePriceYAxisPlotHepler(store: store)
        default:
            return nil
        }
    }
}

struct CandlePlotTheme {
    static let defaultCandleWidth: CGFloat = 5
    
    var topChartScale: CGFloat = 0.7
    
    var candleWidth: CGFloat = CandlePlotTheme.defaultCandleWidth
    var candleGap: CGFloat = 2
    var candleMaxWidth: CGFloat = 30
    var candleMinWIdth: CGFloat = 2
    var candleMinHight: CGFloat = 0.5
    
    var timeXAxisCount = 3
    var timeXAxisFontSize:CGFloat = 11
    var timeXAxisTextColor:UIColor = .white
    var timeXAxisLineColor:UIColor = .lightGray
    
    var priceYAxisCount = 3
    var priceYAxisFontSize:CGFloat = 8
    var priceYAxisTextColor:UIColor = .white
    var priceYAxisLineColor:UIColor = .lightGray
    
    
    
    var volGap: CGFloat = 10
    
    var riseColor: UIColor = .red
    var fallColor: UIColor = .green
    var defaultColor: UIColor = .yellow
    
    var xAxisHeight: CGFloat = 30
    
    var viewMinYGap: CGFloat = 15
}

protocol CandlePlotStoreDelegate {
    var contentOffsetX:CGFloat { get }
    var renderWidth: CGFloat { get }
    var frameHight: CGFloat { get }
}

class CandlePlotStore {
    var contentOffsetX:CGFloat {
        return delegate?.contentOffsetX ?? 0
    }
    
    var renderWidth: CGFloat {
        return delegate?.renderWidth ?? 0
    }
    
    var frameHight: CGFloat {
        return delegate?.frameHight ?? 0
    }
    
    var delegate: CandlePlotStoreDelegate?
    var maxPrice = CGFloat.leastNormalMagnitude
    var minPrice = CGFloat.greatestFiniteMagnitude
    var maxVol = CGFloat.leastNormalMagnitude
    
    var theme = CandlePlotTheme()
    
    var topChartHeight: CGFloat {
        return theme.topChartScale * frameHight
    }
    
    var bottomChartHeight: CGFloat {
        return  (1 - theme.topChartScale) * frameHight - theme.xAxisHeight
        
    }
    
    var startIndex: Int {
        
        let leftCandleCount = Int(startX / (theme.candleWidth + theme.candleGap))
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
        return max(contentOffsetX, 0)
    }
    
    var showCandleCount: Int {
        return Int(renderWidth / ( theme.candleWidth + theme.candleGap))
    }
    
    var priceXAxisIndexGap: Int {
        return showCandleCount / theme.timeXAxisCount
    }
    
    var candlePlotFullWidth: CGFloat {
         
        let width = CGFloat(rawTicks.count) * theme.candleWidth + CGFloat(rawTicks.count + 1) * theme.candleGap
        return width
    }
    
    // 最初資料
    var rawTicks:[Tick] = []
    
    func updateTick(ticks:[Tick]) {
        rawTicks = ticks
    }
    
    func getUnitLayer(type: PlotType) -> CAShapeLayer? {
        if type == .Price {
            clacMaxMinTicks()
        }
        let helper = type.getLayerHelper(self)
        return helper?.plotlayer
    }
    
    private func clacMaxMinTicks() {
        guard rawTicks.count > 0 else { return }
        
        maxPrice = CGFloat.leastNormalMagnitude
        minPrice = CGFloat.greatestFiniteMagnitude
        maxVol = CGFloat.leastNormalMagnitude
        
        let count = min(startIndex + showCandleCount, rawTicks.count)
        for index in startIndex ..< count {
            let raw = rawTicks[index]
            
            maxPrice = max(maxPrice, raw.high.cgFloatValue)
            minPrice = min(minPrice, raw.low.cgFloatValue)
            maxVol = max(maxVol, raw.vol.cgFloatValue)
        }
    }
    
    private func tickIndex(pointX: CGFloat) -> Int {
        let tmp = pointX / ( theme.candleWidth + theme.candleGap)
        return Int(tmp)
    }
    
    func scaleCandleWidth(pointCenterX:CGFloat, diffScale:Double, velocity:CGFloat, callBack:() -> ()) {
        
        var newWidth =  CandlePlotTheme.defaultCandleWidth * (1 + diffScale * (velocity > 0 ? 1 : -1))
        newWidth = max(newWidth, CGFloat(3))
        newWidth = min(newWidth, CGFloat(50))
        theme.candleWidth = newWidth
        // 調整contentize
        callBack()
    }
}


