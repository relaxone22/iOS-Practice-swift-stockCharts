//
//  ChartModelStruct.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/24.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

/// 點的基本模型
struct PointModel {
    var xPosition: CGFloat
    var yPosition: CGFloat
    var lineColor: UIColor
}

/// 基本線圖模型
struct ChartModel {
    
    var maxY,
        minY,
        maxX,
        minX,
        scaleY,
        scaleX: CGFloat
    
    var lineWidth,
        lineSpace: CGFloat
    
    var leftMargin,
        rightMargin,
        topMargin,
        bottomMargin: CGFloat
    
    var lineColor: UIColor
    
    init() {
        maxY = 0
        minY = 0
        maxX = 0
        minX = 0
        scaleY = 0
        scaleX = 0
        
        lineWidth = 2
        lineSpace = 0
        
        leftMargin = 0
        rightMargin = 0
        topMargin = 0
        bottomMargin = 0

        lineColor = UIColor.yellow
    }
}
