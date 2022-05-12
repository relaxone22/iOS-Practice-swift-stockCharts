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
        if let ticks = CandleDataService.shared.list?.ticks {
            candleView.updateTick(ticks: ticks)
        }
    }
    
    private func layout() {
        
        view.addSubview(candleView)
        candleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
            make.left.right.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(5)
        }
    }

}
