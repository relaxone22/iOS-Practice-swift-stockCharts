//
//  ShortCandlePlot.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/11.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit

class ShortCandlePlot: UIView {
    
    var plotmodel: ShortCandlePlotModel?
    
    
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
        plotmodel?.clacMaxMinTicks()
        
        cleanLayers()
    }
    
    func cleanLayers() {
        
    }

}
