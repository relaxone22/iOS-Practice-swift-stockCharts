//
//  ShortCandleChartView.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/10.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit
import SnapKit

class ShortCandleChartView: UIView {
    
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        return view
    }()
    
    var candlePlot: ShortCandlePlot  = {
        let view = ShortCandlePlot()
        return view
    }()
    
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTick(ticks:[Tick]) {
        candlePlot.plotmodel?.updateTick(ticks: ticks)
    }
    
    func setupView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(candlePlot)
        candlePlot.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       
    }
}
