//
//  CandleChartPositionModel.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/10.
//  Copyright © 2022 mitake. All rights reserved.
//

//import Foundation
import UIKit

struct CandleChartPosition {
    var open: CGPoint
    var close: CGPoint
    var high: CGPoint
    var low: CGPoint
    var localIndex: Int
    var date: String
}

class ShortCandleChartSubViewModel {
    
    private var hight: Float
    
    var candleWidth: Float = 10
    private var candleSpace: Float = 3
    
    var maxY: Float = Float.leastNormalMagnitude
    var minY: Float = Float.greatestFiniteMagnitude
    var scaleY: Float
     
    var tickPosition: [CandleChartPosition] = []
    
    required init(ticks: [Tick], hight: Float) {
        self.hight = hight
        self.scaleY = 1
        
        initialize(ticks: ticks)
    }
    
    func initialize(ticks: [Tick]) {
        
        for tick in ticks {
            minY = min(Float(tick.close) ?? minY , minY)
            maxY = max(Float(tick.close) ?? maxY , maxY)
        }
        scaleY = hight / (maxY - minY)
        
        for (index, tick) in ticks.enumerated() {
            let open = ( maxY - (Float(tick.open) ?? 0) ) / scaleY
            let close = ( maxY - (Float(tick.close) ?? 0) ) / scaleY
            let high = ( maxY - (Float(tick.high) ?? 0) ) / scaleY
            let low = ( maxY - (Float(tick.low) ?? 0) ) / scaleY
            
            let left = (candleWidth + candleSpace) * Float(index)
            
            let cgLeft = CGFloat(left)
            let cgOpen = CGPoint(x:cgLeft , y: CGFloat(open))
            let cgClose = CGPoint(x:cgLeft , y: CGFloat(close))
            let cgHigh = CGPoint(x:cgLeft , y: CGFloat(high))
            let cgLow = CGPoint(x:cgLeft , y: CGFloat(low))
            
            let position = CandleChartPosition(open: cgOpen, close: cgClose, high: cgHigh, low: cgLow, localIndex: index, date: tick.date)
            
            tickPosition.append(position)
        }
        
        
        
    }
}
