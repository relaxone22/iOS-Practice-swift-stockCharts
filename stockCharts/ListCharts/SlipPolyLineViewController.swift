//
//  SlipPolyLineViewController.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/26.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

class SlipPolyLineViewController: UIViewController {
// MARK: 宣告變數
    var scrollVIew: UIScrollView = {
       let view = UIScrollView()
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    var chart: SlipPolyLineView?
    
// MARK: 生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollVIew)
        scrollVIew.backgroundColor = UIColor.blue
        
        scrollVIew.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            scrollVIew.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            scrollVIew.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            scrollVIew.widthAnchor.constraint(equalTo: margins.widthAnchor),
            scrollVIew.heightAnchor.constraint(equalToConstant: 200)
            ])
        createPolyLineView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        createPolyLineView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chart?.stockFill()
    }
    
    func createPolyLineView() {
        chart?.removeFromSuperview()
        
        let slipLineView = SlipPolyLineView()
        scrollVIew.addSubview(slipLineView)
        
        chart = slipLineView
    }
    
}
