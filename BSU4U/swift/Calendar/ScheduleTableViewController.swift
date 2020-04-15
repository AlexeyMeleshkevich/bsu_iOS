//
//  ScheduleTableViewController.swift
//  tableSettigins
//
//  Created by Alexey Meleshkevich on 14.12.2019.
//  Copyright © 2019 Li. All rights reserved.
//

import Foundation
import UIKit

class ScheduleTableViewController: UITableViewController {
    
    var lessons = [Lesson]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "C3", for: indexPath) as! ScheduleTableViewControllerCell
        
        cell.timeCell.text = lessons[indexPath.row].getProperty(index: 0)
        cell.typeCell.text = lessons[indexPath.row].getProperty(index: 1)
        cell.lessonCell.text = lessons[indexPath.row].getProperty(index: 2)
        cell.locationCell.text = lessons[indexPath.row].getProperty(index: 3)
        cell.teacherCell.text = lessons[indexPath.row].getProperty(index: 4)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
}
