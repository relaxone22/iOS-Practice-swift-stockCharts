//
//  PolyLineView.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/24.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

class PolyLineView: UIView {
    
    var viewModel = PolyLineModel()
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    init() {
        
        super.init(frame: CGRect.null)
        backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        self.drawLineLayer()
        
    }
    
// MARK: 畫圖開放的方法
    
    /// 開始畫圖
    func stockFill() {
        
        viewModel.config(self.bounds.size.height)
        setNeedsDisplay()
    }
    
    /// 畫曲線圖
    func drawLineLayer() {
        
        
    }
}

/// 資料模型
struct PolyLineModel {
    
    let datas: [Int] = [12, 33, 26, 10, 7, 30, 21]
    let fillColor: UIColor = UIColor.magenta
    let isFillColor: Bool = true
    
    var chartModel: ChartModel
    var points: [PointModel]
    
    init() {
        chartModel = ChartModel()
        points = []
    }
    
    mutating func config(_ height: CGFloat) {
        chartModel = ChartModel()
        
        let deviceWidth = UIScreen.main.bounds.size.width
        chartModel.lineSpace = deviceWidth - chartModel.leftMargin - chartModel.rightMargin
        
        chartModel.maxY = CGFloat(datas.max()!)
        chartModel.minY = CGFloat(datas.min()!)
        chartModel.scaleY = (height - chartModel.topMargin - chartModel.bottomMargin) / (chartModel.maxY - chartModel.minY)
        
        for (index, value) in datas.enumerated() {
            let x = chartModel.lineSpace * CGFloat(index) + chartModel.leftMargin
            let y = (chartModel.maxY - CGFloat(value)) * chartModel.scaleY + chartModel.topMargin
            let point = PointModel(xPosition: x, yPosition: y, lineColor: chartModel.lineColor)
            
            points.append(point)
        }
    }
}
