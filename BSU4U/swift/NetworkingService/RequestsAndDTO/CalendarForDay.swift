//
//  JsonStruct.swift
//  tableSettigins
//
//  Created by Владимир Лишаненко on 1/6/20.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

struct CalendarForDay: Decodable {
    var day: Int
    var data: [Lesson]
}


    
