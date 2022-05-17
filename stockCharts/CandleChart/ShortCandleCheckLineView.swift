//
//  ShortCheckLineView.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/17.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit

class ShortCandleCheckLineView: UIView {
    
    var crossLineLayer = CAShapeLayer()
    var lineWidth: CGFloat
    var lineColor: UIColor
    
    init(lineWidth: CGFloat, lineColor: UIColor) {
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            return nil
        }
        return view
    }
    
    // , priceText:String, volText: String, dateText: String
    func drawCheckLineLayer(price: CGPoint, vol: CGPoint) {
        removeCheckLine()
        
        let line = UIBezierPath()
        //  直線
        line.move(to: CGPoint(x: price.x, y: 0))
        line.addLine(to: CGPoint(x: price.x, y: bounds.maxY))
        // 價格橫線
        line.move(to: CGPoint(x: 0, y: price.y))
        line.addLine(to: CGPoint(x: bounds.maxX, y: price.y))
        // 量橫線
        line.move(to: CGPoint(x: 0, y: vol.y))
        line.addLine(to: CGPoint(x: bounds.maxX, y: vol.y))
        
        crossLineLayer = CAShapeLayer()
        crossLineLayer.lineWidth = lineWidth
        crossLineLayer.strokeColor = lineColor.cgColor
        crossLineLayer.fillColor = lineColor.cgColor
        crossLineLayer.path = line.cgPath
        
        layer.addSublayer(crossLineLayer)
    }
    
    func removeCheckLine() {
        crossLineLayer.removeFromSuperlayer()
    }
}
