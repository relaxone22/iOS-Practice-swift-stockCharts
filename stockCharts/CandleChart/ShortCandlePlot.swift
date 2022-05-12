//
//  ShortCandlePlot.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/11.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit

class ShortCandlePlot: UIView {
    
    var plotmodel = ShortCandlePlotModel()
    
    
    private var candleLayer = CAShapeLayer()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: Draw Charts
    func drawLayers() {
        // 準備資料
        plotmodel.clacMaxMinTicks()
        plotmodel.convertToPositions()
        
        cleanLayers()
        
        let positions =  plotmodel.candlePositions
        drawCandleLayer(positions: positions)
        
        
    }
    
    func cleanLayers() {
        candleLayer.removeFromSuperlayer()
    }
    
    func drawCandleLayer(positions: [CandlePosition]) {
        candleLayer.sublayers?.removeAll()
        
        for position in positions {
            let path = UIBezierPath(rect: position.rect)
            path.move(to: position.low)
            path.move(to: position.high)
            
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.strokeColor = position.color.cgColor
            layer.fillColor = position.color.cgColor
            
            candleLayer.addSublayer(layer)
        }
        layer.addSublayer(candleLayer)
    }
                
}
