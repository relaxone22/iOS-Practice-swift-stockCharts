//
//  CandleChartViewController.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/9.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit
import SnapKit

class CandleChartViewController: UIViewController {
    
    var candleView:ShortCandleChartView = {
        let view = ShortCandleChartView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        CandleDataService.shared.loadData()
        if let ticks = CandleDataService.shared.list?.tick {
            candleView.loadData(ticks: ticks)
        }
    }
    
    private func layout() {
        
        view.addSubview(candleView)
        candleView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(30)
        }
    }

}
