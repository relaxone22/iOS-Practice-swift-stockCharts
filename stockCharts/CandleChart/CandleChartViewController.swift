//
//  CandleChartViewController.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/9.
//  Copyright © 2022 mitake. All rights reserved.
//

import UIKit

class CandleChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CandleDataService.shared.loadData()
    }

}
