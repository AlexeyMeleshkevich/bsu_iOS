import UIKit

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: lessonsView(UITableView) protocols methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case eventsView:
            return 3
        case scheduleView:
             
                   if lessons.count == 0 {
                       self.scheduleView.separatorStyle = .none
                       scheduleView.addSubview(self.noLessonsLabel)
                       self.noLessonsLabel.isHidden = false
                       self.scheduleView.isScrollEnabled = false

                       setLabelLayout()
                       return 0
                   } else {
                       self.scheduleView.isScrollEnabled = true
                       self.scheduleView.separatorStyle = .singleLine
                       self.noLessonsLabel.isHidden = true
                       return lessons.count
                   }
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case eventsView:
            return 100
        case scheduleView:
            return 150
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
                case eventsView:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.eventsCellID, for: indexPath) as! EventsTableViewCell
                    
                    let topics = ["Пьем пиво","Выпиваем Пиво","Допиваем пиво"]
                    let date = ["12:00","15:00","22:00"]
                    
                    cell.eventName.text = "\(topics[indexPath.row])"
                    cell.eventDate.text = "\(date[indexPath.row])"
                    cell.eventDescription.isEditable = false
                    cell.eventDescription.isUserInteractionEnabled = false
        //            cell.layer.cornerRadius = 20
        //            cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        //            cell.layer.shadowOpacity = 0.3
        //            cell.layer.shadowRadius = 2
                    
                    return cell
                case scheduleView:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "C2", for: indexPath) as! ScheduleTableViewCell

                    cell.lessonTime.text = lessons[indexPath.row].getProperty(index: 0)
                    cell.lessonType.text = lessons[indexPath.row].getProperty(index: 1)
                    cell.lessonName.text = lessons[indexPath.row].getProperty(index: 2)
                    cell.lessonLocation.text = lessons[indexPath.row].getProperty(index: 3)
                    cell.teacherName.text = lessons[indexPath.row].getProperty(index: 4)
                    print(lessons[indexPath.row])
                    return cell
                default:
                    return UITableViewCell()
                }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let stroryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = stroryboard.instantiateViewController(withIdentifier: "ScheduleTableViewController") as! ScheduleTableViewController
        vc.lessons = lessons
        self.present(vc, animated: true, completion: nil)
    }
    
    func setLabelLayout() {
           self.noLessonsLabel.centerYAnchor.constraint(equalTo: self.scheduleView.centerYAnchor, constant: 0).isActive = true
           self.noLessonsLabel.centerXAnchor.constraint(equalTo: self.scheduleView.centerXAnchor).isActive = true
       }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Calendar(UICollectionView) protocols methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return DaysInMonth[month] + numberOfEmptyBoxes
//
    }
    
    
    //MARK: Changed Method
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        day = indexPath.row + 1 - numberOfEmptyBoxes
        collectionView.reloadData()
        print(day)
        guard calendarForMonth.count > day - 1 else { return }
        lessons = calendarForMonth[day - 1].data
        checkLessons(lessons: lessons)
        scheduleView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDForCalendar, for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.cellDateLabel.textColor = UIColor.black
        
        if cell.isHidden {
            cell.isHidden = false
        }
          cell.cellDateLabel.text = "\(indexPath.row + 1 - numberOfEmptyBoxes)"
        
        if Int(cell.cellDateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.cellDateLabel.text!)! > 0 {
                cell.cellDateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        if  indexPath.row + 1 == day + numberOfEmptyBoxes{
            cell.backgroundColor = Constants.customBlue
            cell.layer.cornerRadius = cell.frame.width / 2
            cell.cellDateLabel.textColor = UIColor.white
        }
        return cell
    }
    
    func checkLessons(lessons: [Lesson]) {
        var i = 0
        for lesson in lessons {
            if lesson.subject == nil {
                self.lessons.remove(at: i)
            } else {
                i += 1
            }
        }
    }
}
