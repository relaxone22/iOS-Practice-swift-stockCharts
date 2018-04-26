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
                                                                   ("滑動折線圖","SlipPolyLineViewController"),
                                                                   ("k線圖",""),
                                                                   ("分時圖","")]
}

class ListViewController: UITableViewController {
    
    let kTableCellIdentifer: String = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Demo"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kTableCellIdentifer)
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
            viewController.view.backgroundColor = UIColor.gray
            navigationController?.pushViewController(viewController, animated: true)
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
