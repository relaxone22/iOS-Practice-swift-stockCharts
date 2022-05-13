//
//  String+CGFloat.swift
//  stockCharts
//
//  Created by Tony Liu on 2022/5/12.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit

extension String {
    var cgFloatValue: CGFloat {
        guard let doubleValue = Double(self) else { return 0 }
        return CGFloat(doubleValue)
    }
    
    func getTextSize(size:CGFloat) -> CGSize {
        
        let baseFont = UIFont.systemFont(ofSize: size)
        
        let size = self.size(withAttributes: [.font: baseFont])
        let width = ceil(size.width) + 5
        let height = ceil(size.height)
        
        return CGSize(width: width, height: height)
    }
}
