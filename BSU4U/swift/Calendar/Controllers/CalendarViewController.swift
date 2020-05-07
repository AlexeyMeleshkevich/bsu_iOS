import UIKit

class CalendarViewController: UIViewController {
    
    // MARK: Properties
    var informationTypeItem = InformationBarItem()
    var headerLabel = UILabel()
    var calendarForMonth = [CalendarForDay]()
    var headerForLessonsTable = UITableViewHeaderFooterView()
    let leftAndRightPaddings: CGFloat = 74.0
    let numberOfItems: CGFloat = 7.0
    
    var user: AccessType! = .admin
    
    var headerDate: String! {
        didSet(date) {
            self.headerLabel.text = "\(day), \(headerMonths[month])"
        }
    }
    
    var lessons = [LessonsModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.scheduleView.reloadData()
                self?.scheduleView.isHidden = self?.lessons.count == 0 ? true : false
            }
        }
    }
    
    var events: [EventModel] = [EventModel(eventName: "Пьем пиво", eventTime: "12:00", eventDescription: "Собираемся под общагой для культурного времяпровождения", eventFullDescription: "У меня всего лишь свой стиль игры. Есть много разных способов «охоты». Я смотрю канал «Дискавери», и там показывают представителей дикой фауны. У каждого хищника свой способ охоты. Львы отличаются от гиен. Одни делают это стаей, другие используют обдуманную стратегию ту утуттутуттууту пам параааааам пам параааам.", eventImages: [Constants.image!, Constants.image!, Constants.image!, Constants.image!]),
                                EventModel(eventName: "Выпиваем пиво", eventTime: "15:00", eventDescription: "Становится веселее", eventFullDescription: "С момента, когда я начал играть в баскетбол, лишь последние два года использую игру спиной к кольцу. Так что мне по-прежнему нужно много тренироваться, чтобы стать профи в этом деле.", eventImages: nil),
                                EventModel(eventName: "Допиваем пиво", eventTime: "22:00", eventDescription: "Ууууу пажылая гадзилла", eventFullDescription: "Я бы обыграл Джеймса один на один. Я учился этому с детства. ЛеБрон больше как Мэджик Джонсон — хороший распасовщик и играет в разносторонний баскетбол. Я же привык обыгрывать за счет индивидуального мастерства. Могу делать это даже во сне виталя цаль виталя цаль виталя цаль виталя цаль виталя цаль виталя цаль виталя цаль виталя цаль виталя цаль виталя цаль.", eventImages: [ Constants.image!, Constants.image!, Constants.image!, Constants.image!, Constants.image!, Constants.image!, Constants.image!, Constants.image!, Constants.image!])]
    
    let noLessonsLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня занятий нет"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateForEventsHeader: String = String() {
        didSet(date) {
        }
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var eventsView: UITableView!
    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scheduleView: UITableView!
    @IBOutlet weak var weekdayStack: UIStackView!
    
    // MARK: Date for calendar
    
    var DaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    let Months = ["Январь",
                  "Февраль",
                  "Март",
                  "Апрель",
                  "Май",
                  "Июнь",
                  "Июль",
                  "Август",
                  "Сентябрь",
                  "Октябрь",
                  "Ноябрь",
                  "Декабрь"]
    let headerMonths = ["Января",
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
    
    
    //MARK: View Lifecycle methods
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func loadView() {
        super.loadView()
        DaysInMonth[1] = year % 4 == 0 ? 29 :28
        calendar.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        getNumberOfEmptyCellsInCollectionView(calendar: superCalendar, month: month, year: year)
        getLessons()
        scheduleView.reloadData()
        currentMonth = Months[month]
        dateLabel.text = "\(currentMonth) " + "\(year)"
        layout()
        setTableView()
        eventsView.isHidden = true
        
        eventsView.delegate = self
        eventsView.dataSource = self
    }
    
    //MARK: UI methods
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: navigationController, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = informationTypeItem
        self.informationTypeItem.target = self
        self.informationTypeItem.action = #selector(informationItemPressed)
    }
    
    func setTableView() {
        eventsView.separatorStyle = .singleLine
        eventsView.backgroundColor = UIColor.white
        setHeaderLabel()
    }
    
    func setHeaderLabel() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: 36))
        headerLabel = UILabel(frame: header.bounds)
        header.backgroundColor = UIColor.clear
        headerLabel.textAlignment = .center
        headerLabel.textColor = .lightGray
        headerLabel.text = "\(day), \(headerMonths[month])"
        header.addSubview(headerLabel)
        headerLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        scheduleView.tableHeaderView = header
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
    
    //MARK: Layout method
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
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
            self.eventsView.isHidden = true
        }, completion: nil)
    }
    
    @IBAction func next(_ sender: Any) {
        DaysInMonth[1] = year % 4 == 0 ?29 :28
        switch currentMonth {
        case "Декабрь":
            month = 0
            year += 1
            
            getNumberOfEmptyCellsInCollectionView(calendar: superCalendar, month: month, year: year)
            getLessons()
            
            
            currentMonth = Months[month]
            dateLabel.text = "\(currentMonth) " + "\(year)"
            calendar.reloadData()
            eventsView.reloadData()
        default:
            
            month += 1
            getNumberOfEmptyCellsInCollectionView(calendar: superCalendar, month: month, year: year)
            getLessons()
            
            currentMonth = Months[month]
            dateLabel.text = "\(currentMonth) " + "\(year)"
            calendar.reloadData()
            eventsView.reloadData()
        }
        day = current_month_i == month && current_year_i == year ? current_day_i: -1
        
    }
    
    @IBAction func back(_ sender: Any) {
        switch currentMonth {
        case "Январь":
            month = 11
            year -= 1
            
            
            DaysInMonth[1] = year % 4 == 0 ?29 :28
            getNumberOfEmptyCellsInCollectionView(calendar: superCalendar, month: month, year: year)
            getLessons()
            
            
            currentMonth = Months[month]
            dateLabel.text = "\(currentMonth) " + "\(year)"
            calendar.reloadData()
            eventsView.reloadData()
        default:
            month -= 1
            
            getNumberOfEmptyCellsInCollectionView(calendar: superCalendar, month: month, year: year)
            getLessons()
            
            
            currentMonth = Months[month]
            dateLabel.text = "\(currentMonth) " + "\(year)"
            calendar.reloadData()
            eventsView.reloadData()
        }
        day = current_month_i == month && current_year_i == year ? current_day_i: -1
        
    }
    
    @objc func informationItemPressed() {
        switch informationTypeItem.currentState {
        case .education:
            flipEducation()
        case .events:
            flipBolt()
        }
        
        self.informationTypeItem.changeState()
    }
}
