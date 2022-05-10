//
//  ShortCandleChartView.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/10.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit
import SnapKit

class ShortCandleChartView: UIScrollView {
    var candleChartSubView: ShortCandleChartSubView  = {
        let view = ShortCandleChartSubView()
        return view
    }()
    
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    func loadData(ticks:[Tick]) {
        candleChartSubView.loadData(ticks: ticks)
    }
    
    func setupView() {
        isScrollEnabled = true
        bounces = true
        showsVerticalScrollIndicator = false
        backgroundColor = .white
        
        addSubview(candleChartSubView)
        candleChartSubView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
