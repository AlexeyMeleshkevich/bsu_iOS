import Foundation
import UIKit

class ScheduleTableViewController: UITableViewController {
    
    var headerLabel = UILabel()
    
    var headerDate: String = "" {
        didSet(date) {
            self.headerLabel.text = date
        }
    }
    
    var lessons = [LessonsModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Расписание занятий"
        
        setHeaderLabel()
        headerLabel.text = headerDate
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
    
    func setHeaderLabel() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.tableView.frame.width), height: 36))
        headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "Hello"
        header.backgroundColor = UIColor.clear
        headerLabel.textAlignment = .center
        headerLabel.textColor = .lightGray
        header.addSubview(headerLabel)
        headerLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        tableView.tableHeaderView = header
    }
}
