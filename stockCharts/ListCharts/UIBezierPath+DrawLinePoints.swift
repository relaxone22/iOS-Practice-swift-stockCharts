//
//  UIBezierPath+DrawLinePoints.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/26.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

// MARK: 擴充方法
extension UIBezierPath {
    
    class func drawLine(points: [PointModel]) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        for (index, point) in points.enumerated() {
            
            if index == 0 {
                path.move(to: CGPoint(x: point.xPosition, y: point.yPosition))
            }
            else {
                path.addLine(to: CGPoint(x: point.xPosition, y: point.yPosition))
            }
        }
        
        return path
    }
}
