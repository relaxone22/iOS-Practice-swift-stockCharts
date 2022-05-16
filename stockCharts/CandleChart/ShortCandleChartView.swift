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
        
        adjustContentWidth()
    }
    
    func adjustContentWidth() {
        let contentWidth = max(frame.width, candlePlot.store.candlePlotFullWidth)
        
        scrollView.contentLayoutGuide.snp.remakeConstraints { make in
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
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        candlePlot.addGestureRecognizer(pinch)
        
    }
    
    @objc func handlePinch(_ recognizer: UIPinchGestureRecognizer) {
        
        guard recognizer.numberOfTouches == 2 else { return }
        
        let scale = recognizer.scale
        let defaultScale = 1.0
        let diff = scale - defaultScale
        
        if recognizer.state == .began {
            scrollView.isScrollEnabled = false
        }
        else {
            scrollView.isScrollEnabled = true
        }
        
        if abs(diff) != 0 {
            let point1 = recognizer.location(ofTouch: 0, in: self)
            let point2 = recognizer.location(ofTouch: 1, in: self)
            
            let pointCenterX = max(0, (point1.x + point2.x) / 2 + scrollView.contentOffset.x)
            candlePlot.store.scaleCandleWidth(pointCenterX: pointCenterX, diffScale: diff, velocity: recognizer.velocity, callBack: { newContentOffsetX in
                adjustContentWidth()
                scrollView.contentOffset.x = newContentOffsetX
                candlePlot.drawLayers()
            })
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
        return bounds.height
    }
    
    
}
