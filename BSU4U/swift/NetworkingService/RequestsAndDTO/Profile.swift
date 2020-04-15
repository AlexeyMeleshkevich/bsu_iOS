//
//  File.swift
//  tableSettigins
//
//  Created by Владимир Лишаненко on 2/19/20.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

struct Profile: Decodable {
       let faculty:     String
       let speciality:   String
       let course:      String
       let group_number:String
       let form:        String
       let email:       String
       let address:     String
       let name:        String
       let surname:     String
       let fathername:  String
       var image : String
       
       func getProperty(index : Int) -> String {
           switch index {
           case 0: return self.faculty
           case 1: return self.speciality
           case 2: return "\(self.course), \(group_number)"
           case 3:
               if self.form == "1" {
                   return "Дневная, бюджет"
               } else {
                   return "Дневная, платная"
               }
           case 4: return "\(self.email)"
           case 5: return self.address
           default:
               return "error"
           }
       }
       
       func getImage() -> UIImage? {
           let base64 = self.image.replacingOccurrences(of: "data:image/jpeg;base64,", with: "")
           let imageData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters)!
           let image = UIImage(data: imageData)
           return image
       }

       init() {
           self.image = String()
           self.name = String()
           self.surname =   String()
           self.fathername =  String()
           self.address =     String()
           self.email =       String()
           self.course =      String()
           self.form =        String()
           self.group_number = String()
           self.speciality =   String()
           self.faculty =      String()
       }
}
   
   
   
