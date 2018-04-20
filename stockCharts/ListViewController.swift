//
//  ListViewController.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/17.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

// MARK: 資料結構
struct chartList {
    static let charts:[(title: String, viewController: String)] = [("折線圖","PolyLineViewController"),
                                                                   ("滑動折線圖",""),
                                                                   ("k線圖",""),
                                                                   ("分時圖","")]
}

class ListViewController: UITableViewController {
    
    let kTableCellIdentifer: String = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Demo"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: kTableCellIdentifer)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chart = chartList.charts[indexPath.row]
        let displayName = Bundle.main.displayName ?? ""
        
        if let aClass: UIViewController.Type = NSClassFromString(displayName + "." + chart.viewController) as? UIViewController.Type {
            let viewController = aClass.init()
            viewController.navigationItem.title = chart.title
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chartList.charts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableCellIdentifer, for: indexPath)
        let chart = chartList.charts[indexPath.row]
    
        cell.textLabel?.text = chart.title
        
        return cell
    }
}

private extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
