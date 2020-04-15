//
//  HistoryViewController.swift
//  tableSettigins
//
//  Created by Li on 12/11/19.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateLayout(with: view.frame.size)
    }
    
    private func updateUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "История платежей"
        navigationController?.navigationBar.tintColor = .white
        
        let button = UIBarButtonItem()
        button.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = button
        
        self.tableView.register(HistoryCell.self, forCellReuseIdentifier: "HistoryCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelection = false
        
        self.view.addSubview(tableView)
        
        
    }
    
    private func updateLayout(with size : CGSize){
        self.tableView.frame = CGRect(origin: .zero, size: size)
    }
    
}


extension HistoryViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderHistoryView.init(frame: CGRect.init(x: 20, y: 0, width: view.frame.width - 40, height: 44))
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
        cell.contentView.frame = CGRect(x: 20, y: 0, width: view.frame.width-40, height: 44)
        cell.updateUI()
        cell.typeLabel.text = "Оплата за общежитие"
        cell.amountLabel.text = "30.6 руб"
        cell.dateLabel.text = "\(day).\(month).\(year)"
        
        return cell
        
    }
}
