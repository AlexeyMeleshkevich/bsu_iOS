//
//  File1.swift
//  tableSettigins
//
//  Created by Владимир Лишаненко on 2/19/20.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

struct Login: Codable {
    
    let login: String?
    let password:  String?
    var deviceID: String?
    
    init(login: String, pass: String) {
        self.login = login
        self.deviceID = UIDevice.current.identifierForVendor?.uuidString
        self.password = pass
    }
}
