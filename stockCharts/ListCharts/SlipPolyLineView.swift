//
//  SlipPolyLineView.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/26.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

class SlipPolyLineView: UIView {
// MARK: property
    fileprivate var viewModel = SlipPolyLineModel()
    lazy var superScrollView: UIScrollView? = self.superview as? UIScrollView
    
// MARK: initialize
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.black
    }
    
// MARK: internal method
    /// 開始畫圖
    func stockFill() {
        viewModel.config(size: superScrollView!.bounds.size)
        configContentWidth()
        drawLineLayer()
    }
    
// MARK: fileprivate method
    fileprivate func configContentWidth() {
        let model = viewModel.chartModel
        let contentWidth = model.lineSpace * CGFloat(viewModel.datas.count - 1) + model.leftMargin + model.rightMargin
        let contenrHeight = superScrollView!.bounds.height
        frame = CGRect(x: 0, y: 0, width: contentWidth, height: contenrHeight)
        superScrollView?.contentSize = CGSize(width: contentWidth, height: 0)
    }
    
    /// 畫曲線圖
    fileprivate func drawLineLayer() {
        // 畫圖
        let path = UIBezierPath.drawLine(points: viewModel.points)
        
        let chartModel = viewModel.chartModel
        let polyLineLayer = CAShapeLayer()
        polyLineLayer.path = path.cgPath
        polyLineLayer.strokeColor = chartModel.lineColor.cgColor
        polyLineLayer.fillColor = UIColor.clear.cgColor
        
        polyLineLayer.lineWidth = chartModel.lineWidth
        polyLineLayer.lineCap = kCALineCapRound
        polyLineLayer.lineJoin = kCALineJoinRound
        polyLineLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(polyLineLayer)
        
        // 動畫
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = 0
        animation.toValue = 1
        polyLineLayer.add(animation, forKey: nil)
    }
}

// MARK: 資料模型
fileprivate struct SlipPolyLineModel {
    let datas: [Int] = [12,33,44,55,7,10,28,12,33,11,63,7,10,66,12,41,28,12,55,77,21,12,33,54,30,7,20,21,12,33,44,55,7,10,28,12,33,11,63,7,10,66,12,41,28,12,55,77,21,12,33]
    
    var chartModel: ChartModel = {
        var model = ChartModel()
        model.leftMargin = 10
        model.rightMargin = 10
        model.topMargin = 10
        model.bottomMargin = 10
        return model
    }()
    var points: [PointModel] = []
    
    mutating func config(size: CGSize) {
        
        let height = size.height
        let width = size.width
        let pointWidth = CGFloat(10)
        
        chartModel.lineSpace = width / pointWidth
        
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
