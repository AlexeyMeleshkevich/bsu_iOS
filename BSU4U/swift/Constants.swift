//
//  Constants.swift
//  BSU
//
//  Created by Alexey Meleshkevich on 27/11/2019.
//  Copyright © 2019 Alexey Meleshkevich. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
   
    
    static let SEGMENT_SET_ITEMS = [UIImage(named: "education"),
                                    UIImage(named: "money"),
                                    UIImage(named: "star")]
    
    static let SETTINGS_NAME_CELL = ["Уведомления", "Приватность", "Аккаунт",
                                     "Язык", "О приложении", "Выйти"]
    
    static let SETTINGS_ICONS_NAME_CELL = ["bell", "key", "user",
                                           "globe", "info", "exit"]
    
    static let USER_INFO_NAME_CELL = ["Факультет", "Специальность", "Курс, группа",
                                      "Форма обучения", "Почта",
                                      "Адресс проживания"]
    static let CREDIT_NAME_CELL = ["Оплата за обучение", "Пересдачи", "За общежитие", "История платежей"]
   
    
    
    static let customBlue = UIColor(red: 20.0 / 255.0, green: 78.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
    
    static let currentDayTime = ["9:00 - 10:20",
                                 "10:30 - 11:50",
                                 "12:00 - 13:20",
                                 "13:50 - 15:10",
                                 "15:20 - 16:40",
                                 "прокоповичтайм",]
    
    static let eventsCellID = "С.events"
    
    static let CalendarCellID = "C1"
    
    static let scheduleControllerID = "ScheduleTableViewController"
    
    static let eventsControllerID = "EventsTableViewController"
    
}
