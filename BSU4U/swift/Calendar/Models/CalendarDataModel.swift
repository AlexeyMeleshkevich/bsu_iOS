//
//  CalendarDataModel.swift
//  BSU
//
//  Created by Alexey Meleshkevich on 18/11/2019.
//  Copyright © 2019 Alexey Meleshkevich. All rights reserved.
//

import Foundation

let date = Date()
let superCalendar = Calendar.current

var day = superCalendar.component(.day, from: date)
var weekday = superCalendar.component(.weekday, from: date)
var month = superCalendar.component(.month, from: date) - 1
var year = superCalendar.component(.year, from: date)

let current_day_i = superCalendar.component(.day, from: date)
let current_month_i = superCalendar.component(.month, from: date) - 1
var current_year_i = superCalendar.component(.year, from: date)



