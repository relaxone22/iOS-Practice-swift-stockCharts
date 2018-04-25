//
//  PolyLineViewController.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/20.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

class PolyLineViewController: UIViewController {
    
    var chart: PolyLineView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        self.createPolyLineView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chart?.stockFill()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.createPolyLineView()
    }
    
    func createPolyLineView() {
        
        chart?.removeFromSuperview()
        
        let lineView = PolyLineView()
        view.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            lineView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            lineView.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            lineView.widthAnchor.constraint(equalTo: margins.widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        chart = lineView
        
    }
}
