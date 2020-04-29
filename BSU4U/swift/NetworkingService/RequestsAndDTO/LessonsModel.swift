//
//  File.swift
//  tableSettigins
//
//  Created by Владимир Лишаненко on 2/19/20.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

struct LessonsModel: Decodable {
    var time_start: String?
    var time_end: String?
    var audience: String?
    var building: String?
    var surname: String?
    var name: String?
    var fathername: String?
    var subject: String?
    var type: String?
    
    
    func getProperty(index : Int) -> String? {
        switch index {
        case 0: return "\(self.time_start?.dropLast(3) ?? "") - \(self.time_end?.dropLast(3) ?? "")"
        case 1: return self.type ?? ""
        case 2: return self.subject
        case 3:
            if let _ = self.audience {
                return "ул. \(self.building ?? ""), каб. \(self.audience ?? "")"
            } else if let _ = self.building {
                return "ул. \(self.building ?? "")"
            } else {
                return ""
            }
            
        case 4: return "\(self.surname ?? "") \(self.name ?? "") \(self.fathername ?? "")"
            
        default:
            return "error"
        }
    }
}
