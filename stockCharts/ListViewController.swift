//
//  ListViewController.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/17.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var titles: [String] = ["折線圖","滑動折線圖","k線圖","分時圖"]
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableCellIdentifer, for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        
        return cell
    }
}
