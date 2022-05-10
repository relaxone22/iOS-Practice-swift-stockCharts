//
//  CandleDataHelper.swift
//  stockCharts
//
//  Created by TDCC_IFD on 2022/5/9.
//  Copyright © 2022 mitake. All rights reserved.
//

import Foundation

struct CandleData: Codable {
    var code: String
    var type: String
    var tick: [Tick]
}

struct Tick: Codable {
    var date: String
    var current: String
    var open: String
    var preclose: String?
    var change: String
    var vol: String
    var close: String
    var high: String
    var low: String
}


class CandleDataService {
    static let shared = CandleDataService()
    var list: CandleData?
    
    func loadData() {
        readFile()
//        print(list)
    }
    
    private func readFile() {
            let fileName = "CandleData"
            guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
                return
            }
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                list = try JSONDecoder().decode(CandleData.self, from: data)
                
            } catch {
                print(error)
            }
        }
}
