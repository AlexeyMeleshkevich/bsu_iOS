//
//  SettingsViewController.swift
//  BSU
//
//  Created by Li on 12/2/19.
//  Copyright © 2019 Alexey Meleshkevich. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{
   
    let tableView = UITableView(frame: .zero, style: .grouped)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateLayout(with: self.view.frame.size)
    }
    
    private func updateLayout(with size : CGSize){
        self.tableView.frame = CGRect(origin: .zero, size: size)
    }
    
    private func updateUI(){
     
        self.tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        self.view.addSubview(tableView)
    }
    
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.SETTINGS_NAME_CELL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsTableViewCell
        cell.textLabel?.text = Constants.SETTINGS_NAME_CELL[indexPath.row]
        
        switch indexPath.row {
        case 0...4: cell.accessoryType = .disclosureIndicator
        default: break
        }
        
        switch indexPath.row {
        case 4: cell.textLabel?.textColor = .systemBlue
        case 5: cell.textLabel?.textColor = .systemRed
        default: break
        }
        cell.imageView?.image = UIImage(named: Constants.SETTINGS_ICONS_NAME_CELL[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 5:
            UserDefaults.standard.removeObject(forKey: "Token")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        default:
            print("1")
        }
    }
}
