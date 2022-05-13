//
//  ShortCandlePlot.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/11.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit

class ShortCandlePlot: UIView {
    
    var store = CandlePlotStore()
    var plotTypes:[PlotType] = [.Price, .Vol, .PriceXAxis, .PriceYAxis]
    
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: Draw Charts
    func drawLayers() {
        cleanLayers()
        for (index, type) in plotTypes.enumerated() {
            if let subLayer = store.getUnitLayer(type: type) {
                layer.addSublayer(subLayer)
                subLayer.zPosition = CGFloat(plotTypes.count - index)
            }
        }
    }
    
    func cleanLayers() {
        layer.sublayers?.removeAll()
    }
    
   
                
}
