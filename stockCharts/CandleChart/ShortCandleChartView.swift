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
        view.backgroundColor = .black
        
        return view
    }()
    
    var candlePlot: ShortCandlePlot  = {
        let view = ShortCandlePlot()
        return view
    }()
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UIScrollView.contentOffset) {
            candlePlot.drawLayers()
        }
    }
    
    func updateTick(ticks:[Tick]) {
        candlePlot.store.delegate = self
        candlePlot.store.updateTick(ticks: ticks)
        candlePlot.drawLayers()
        
        let contentWidth = max(frame.width, candlePlot.store.candlePlotFullWidth)
        
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(contentWidth)
        }
    }
    
    func setupView() {
        addSubview(scrollView)
        scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset), options: .new, context: nil)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.frameLayoutGuide)
        }
        
        scrollView.addSubview(candlePlot)
        candlePlot.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
        }
    }
}

extension ShortCandleChartView:CandlePlotStoreDelegate {
    var contentOffsetX: CGFloat {
        return scrollView.contentOffset.x
    }
    
    var renderWidth: CGFloat {
        return frame.width
    }
    
    var frameHight: CGFloat {
        return frame.height
    }
    
    
}
