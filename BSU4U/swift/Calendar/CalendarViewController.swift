import UIKit

class CalendarViewController: UIViewController{
    
    
    //MARK: Property( Ebany rot chto oni znachat vapshe)
    var calendarForMonth = [CalendarForDay]()
    let leftAndRightPaddings: CGFloat = 74.0
    let numberOfItems: CGFloat = 7.0
    let educationImage = UIImage(named: "education")
    let boltImage = UIImage(systemName: "bolt")
    public let IDForCalendar = "C1"

    var lessons = [Lesson]()
    {
        didSet {
            DispatchQueue.main.async {
                self.scheduleView.reloadData()
                self.scheduleView.isHidden = self.lessons.count == 0 ? true : false
            }
        }
    }
    
    let noLessonsLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня занятий нет"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var informationState: String = String() {
        didSet(type) {
            switch type {
            case "education":
                self.setInformationItem(with: type)
            case "bolt":
                self.setInformationItem(with: type)
            default:
                break
            }
        }
    }
    
    @IBOutlet weak var eventsView: UITableView!
    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scheduleView: UITableView!
    @IBOutlet weak var informationTypeItem: UIBarButtonItem!
    @IBOutlet weak var weekdayStack: UIStackView!
    
    // MARK: Date for calendar
    let Months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    var DaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
   let stringMonths = ["Января",
   "Февраля",
   "Марта",
   "Апреля",
   "Мая",
   "Июня",
   "Июля",
   "Августа",
   "Сентября",
   "Октября",
   "Ноября",
   "Декабря"]
    
    
    var numberOfEmptyBoxes = 2
 
    var currentMonth = String()
    
    public var headerForLessonsTable = UITableViewHeaderFooterView()
    
    
    //MARK: Controller Lifecycle methods
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.informationState = "bolt"
        eventsView.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        DaysInMonth[1] = year % 4 == 0 ?29 :28
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        getNumberOfEmptyCellsInCollectionView(calendar: calendarForEblya, month: month, year: year)
        getLessons()
        scheduleView.reloadData()
        currentMonth = Months[month]
        dateLabel.text = "\(currentMonth) " + "\(year)"
        layout()
        self.eventsView.backgroundColor = UIColor.clear
        setTableView()
        
    }
    
    //MARK: Methods for eblya with cells
    
    func setTableView() {
            eventsView.separatorStyle = .none
    //        eventsView.backgroundColor = UIColor.systemGray5
            setHeaderLabel()
        }

        func setHeaderLabel() {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.eventsView.frame.width), height: 36))
            let headerLabel = UILabel(frame: header.bounds)
            header.backgroundColor = UIColor.clear
            headerLabel.textAlignment = .center
            headerLabel.textColor = .lightGray
            headerLabel.text = "\(day), \(stringMonths[month])"
            header.addSubview(headerLabel)
            
            eventsView.tableHeaderView = header
        }
    
    func getNumberOfEmptyCellsInCollectionView(calendar: Calendar, month: Int, year: Int )  {
        
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = month + 1
        dateComponents.year = year
        
        
        guard let firstDayInCurrentMonth = calendar.date(from: dateComponents) else { return }
        let weekday = calendar.component(.weekday, from: firstDayInCurrentMonth)
        
        switch weekday {
        case 2...7:
            numberOfEmptyBoxes = weekday - 2
        default:
            numberOfEmptyBoxes = 6
        }

    }
    
    
    @IBAction func back(_ sender: Any) {
        switch currentMonth {
        case "Январь":
            month = 11
            year -= 1
         
            
            DaysInMonth[1] = year % 4 == 0 ?29 :28
            getNumberOfEmptyCellsInCollectionView(calendar: calendarForEblya, month: month, year: year)
            getLessons()
                       

            currentMonth = Months[month]
            dateLabel.text = "\(currentMonth) " + "\(year)"
            calendar.reloadData()
        default:
            month -= 1
      
             getNumberOfEmptyCellsInCollectionView(calendar: calendarForEblya, month: month, year: year)
            getLessons()
          
            
            currentMonth = Months[month]
            dateLabel.text = "\(currentMonth) " + "\(year)"
            calendar.reloadData()
        }
        day = current_month_i == month && current_year_i == year ? current_day_i: -1
                   
    }
    
    
    @IBAction func next(_ sender: Any) {
        DaysInMonth[1] = year % 4 == 0 ?29 :28
        switch currentMonth {
        case "Декабрь":
            month = 0
            year += 1
            
            getNumberOfEmptyCellsInCollectionView(calendar: calendarForEblya, month: month, year: year)
            getLessons()
                       
            
            currentMonth = Months[month]
            dateLabel.text = "\(currentMonth) " + "\(year)"
            calendar.reloadData()
        default:

            month += 1
            getNumberOfEmptyCellsInCollectionView(calendar: calendarForEblya, month: month, year: year)
            getLessons()
            
            currentMonth = Months[month]
            dateLabel.text = "\(currentMonth) " + "\(year)"
            calendar.reloadData()
        }
         day = current_month_i == month && current_year_i == year ? current_day_i: -1
                   
    }
    
    func getLessons() {
          
          
          let api = ApiRequest(endpoint: "api/timetable/\(month + 1)")
          api.getLesson { (result) in
              switch result {
              case.failure(let error) :
                  print(error)
                  self.calendarForMonth = [CalendarForDay]()
              case.success(let lessonsForMonth) :
                  self.calendarForMonth = lessonsForMonth
                  print(self.calendarForMonth)
              }
          }
      }
    
    //MARK: methods for eblya with Layout
    func layout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let side = (view.frame.width - leftAndRightPaddings) / numberOfItems
        layout.itemSize = CGSize(width: side, height: side)
        calendar.collectionViewLayout = layout
        let constant = side * CGFloat((numberOfEmptyBoxes + 7 + DaysInMonth[month]) / 7).rounded(.up)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        scheduleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: weekdayStack.topAnchor, constant: 30),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            calendar.widthAnchor.constraint(equalToConstant: view.frame.width),
            calendar.heightAnchor.constraint(equalToConstant: constant + 100),
            scheduleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scheduleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scheduleView.widthAnchor.constraint(equalToConstant: view.frame.width),
            scheduleView.heightAnchor.constraint(equalToConstant: view.frame.height - constant - 300)])
                                    
    }
    
    func setInformationItem(with state: String) {
        switch state {
        case "education":
            self.informationTypeItem.image = educationImage
        case "bolt":
            self.informationTypeItem.image = boltImage
        default:
            break
        }
    }
    
    @IBAction func switchActivity(_ sender: Any) {
        switch informationState {
        case "bolt":
            self.informationState = "education"
            self.informationTypeItem.image = educationImage
            flipEducation()
        case "education":
            self.informationState = "bolt"
            self.informationTypeItem.image = boltImage
            flipBolt()
        default:
            break
        }
    }
    
    
    func flipEducation() {
        let transOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: scheduleView, duration: 1.0, options: transOptions, animations: {
            self.scheduleView.isHidden = true
        }, completion: nil)
        
        UIView.transition(with: eventsView, duration: 1.0, options: transOptions, animations: {
            self.eventsView.isHidden = false
        }, completion: nil)
    }
    
    func flipBolt() {
        let transOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
        UIView.transition(with: scheduleView, duration: 1.0, options: transOptions, animations: {
            self.scheduleView.isHidden = false
        }, completion: nil)
        
        UIView.transition(with: eventsView, duration: 1.0, options: transOptions, animations: {
            self.eventsView.isHidden = true
        }, completion: nil)
    }
}
