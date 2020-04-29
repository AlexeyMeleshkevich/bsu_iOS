//
//  InformationPresenter.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 17.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class InformationPresenter {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var parent: UIViewController!
    var controllerID: String
    
    required init(in parent: UIViewController, id viewController: String, data: (Any?, String)) {
        self.parent = parent
        self.controllerID = viewController
        
        presentViewController(with: data)
    }
    
    func presentViewController(with data: (Any?, String)?) {
        
        guard let dataForVC = data else { showError(); return }
        
        switch controllerID {
        case "ScheduleTableViewController":
            let vc = storyboard.instantiateViewController(withIdentifier: controllerID) as! ScheduleTableViewController
            guard let lessons = dataForVC.0 as? [LessonsModel] else { return }
            vc.lessons = lessons
            vc.headerDate = dataForVC.1
            parent.navigationController?.pushViewController(vc, animated: true)
        case "EventsTableViewController":
            let vc = storyboard.instantiateViewController(withIdentifier: controllerID) as! EventsViewController
            guard let events = dataForVC.0 as? [EventModel] else { return }
            vc.events = events
            vc.headerDate = dataForVC.1
            parent.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
    
    func showError() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showError(withStatus: "Ошибка")
    }
}
