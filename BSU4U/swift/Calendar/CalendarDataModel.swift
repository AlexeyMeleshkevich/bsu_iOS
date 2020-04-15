//
//  CalendarDataModel.swift
//  BSU
//
//  Created by Alexey Meleshkevich on 18/11/2019.
//  Copyright © 2019 Alexey Meleshkevich. All rights reserved.
//

import Foundation

let date = Date()
let calendarForEblya = Calendar.current

var day = calendarForEblya.component(.day, from: date)
var weekday = calendarForEblya.component(.weekday, from: date)
var month = calendarForEblya.component(.month, from: date) - 1
var year = calendarForEblya.component(.year, from: date)

let current_day_i = calendarForEblya.component(.day, from: date)
let current_month_i = calendarForEblya.component(.month, from: date) - 1
var current_year_i = calendarForEblya.component(.year, from: date)



