//
//  ShortCandleChartSubView.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/10.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit

class ShortCandleChartSubView: UIView {
    
    var model:ShortCandleChartSubViewModel?
    
    var positions: [CandleChartPosition] {
        return model?.tickPosition ?? []
    }
    
    lazy var redLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = (1.5 / UIScreen.main.scale)
        layer.fillColor = UIColor.red.cgColor
        layer.strokeColor = UIColor.red.cgColor
        return layer
    }()
    
    var greenLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = (1.5 / UIScreen.main.scale)
        layer.fillColor = UIColor.green.cgColor
        layer.strokeColor = UIColor.green.cgColor
        return layer
    }()
    
    var superScrollView: UIScrollView? {
        return superview as? UIScrollView
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(ticks:[Tick]) {
        
        self.model = ShortCandleChartSubViewModel(ticks: ticks, hight: Float(frame.size.height) )
        stockFill()
    }
    
    func stockFill() {
        initLayer()
        drawCandleSublayers()
    }
    
    private func initLayer() {
        layer.addSublayer(redLayer)
        layer.addSublayer(greenLayer)
        
        
    }
    
    
//MARK: draw related
    
    private func drawCandleSublayers() {
        var redPath = CGMutablePath()
        var greenPath = CGMutablePath()
        
        for (_, position) in positions.enumerated() {

            if position.open.y > position.close.y {
                addCandlePath(&redPath, position: position)
            }
            else {
                addCandlePath(&redPath, position: position)
            }
        }
        
        redLayer.path = redPath;
//        greenLayer.path = greenPath;
        
    }
    
    private func addCandlePath(_ path: inout CGMutablePath, position: CandleChartPosition) {
        
        let x = position.open.x
        let y = min(position.open.y, position.close.y)
        let width = CGFloat(model?.candleWidth ?? 5)
        let hight = abs(position.open.y - position.close.y)
        
        let rect = CGRect(x: x, y: y, width: width, height: hight)
        
        path.addRect(rect)
        
        let xPostion = x + CGFloat(model!.candleWidth);
        
        if (position.close.y < position.open.y) {
            
            if ( abs(position.close.y - position.high.y) != 0 ) {
                let point = CGPoint(x: xPostion, y: position.close.y)
                path.move(to: point)
                let point2 = CGPoint(x: xPostion, y: position.high.y)
                path.addLine(to: point2)
            }
            if ( abs(position.low.y - position.open.y) != 0 ) {
                let point = CGPoint(x: xPostion, y: position.low.y)
                path.move(to: point)
                let point2 = CGPoint(x: xPostion, y: position.open.y + width/2)
                path.addLine(to: point2)
            }
        }
        else {
            if ( abs(position.close.y - position.high.y) != 0 ) {
                let point = CGPoint(x: xPostion, y: position.close.y)
                path.move(to: point)
                let point2 = CGPoint(x: xPostion, y: position.high.y)
                path.addLine(to: point2)
            }
            if ( abs(position.low.y - position.open.y) != 0 ) {
                let point = CGPoint(x: xPostion, y: position.low.y)
                path.move(to: point)
                let point2 = CGPoint(x: xPostion, y: position.open.y + width/2)
                path.addLine(to: point2)
            }
        }
        
    }

    
    

}
