//
//  ProfileTableViewController.swift
//  tableSettigins
//
//  Created by Li on 12/10/19.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class InfoPageTableViewController: UITableViewController {
    
    var profile = Profile() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        tableView.backgroundColor = .white
        tableView.register(UserInfoCell.self, forCellReuseIdentifier: "UserInfoCell")
        tableView.allowsSelection = false
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Constants.USER_INFO_NAME_CELL.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as! UserInfoCell
        
        cell.contentView.frame = CGRect(x: 20, y: 0, width: view.frame.width-40, height: 70)
        cell.updateUI()
        cell.infoNameLabel.text = Constants.USER_INFO_NAME_CELL[indexPath.row]
        cell.infoLabel.text = profile.getProperty(index: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: -Delegate
    
}
