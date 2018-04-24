//
//  PolyLineViewController.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/20.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

class PolyLineViewController: UIViewController {
    
    lazy var lineView: PolyLineView = {
        
        let chart = PolyLineView()
        view.addSubview(chart)
        
        // layout
        chart.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            chart.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            chart.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            chart.widthAnchor.constraint(equalTo: margins.widthAnchor),
            chart.heightAnchor.constraint(equalToConstant: 200)
            ])

        return chart
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        lineView.stockFill()
    }
}
