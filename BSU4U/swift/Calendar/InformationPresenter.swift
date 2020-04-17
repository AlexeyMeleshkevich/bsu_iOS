//
//  InformationPresenter.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 17.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

class InformationPresenter {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var parent: UIViewController!
    var controllerID: String
    
    required init(in parent: UIViewController, id viewController: String, data: Any?) {
        self.parent = parent
        self.controllerID = viewController
        
        presentViewController(with: data)
    }
    
    func presentViewController(with data: Any?) {
        
        switch controllerID {
        case "ScheduleTableViewController":
            let vc = storyboard.instantiateViewController(withIdentifier: controllerID) as! ScheduleTableViewController
            vc.lessons = data as! [Lesson]
            parent.navigationController?.present(vc, animated: true, completion: nil)
        case "EventsTableViewController":
            let vc = storyboard.instantiateViewController(withIdentifier: controllerID) as! EventsViewController
            parent.navigationController?.present(vc, animated: true, completion: nil)
        default:
            return
        }
    }
}
