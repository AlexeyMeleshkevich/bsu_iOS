import Foundation
import UIKit
import SVProgressHUD

typealias HeaderText = String

enum AccessType {
    case admin
    case user
}

class ActivityRouter {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var parent: UIViewController!
    var controllerID: String
    
    required init(in parent: UIViewController, id viewController: String, data: (Any?, HeaderText, AccessType)) {
        self.parent = parent
        self.controllerID = viewController
        
        presentViewController(with: data)
    }
    
    func presentViewController(with data: (Any?, HeaderText, AccessType)?) {
        guard let dataForVC = data else { showError(); return }
        
        switch controllerID {
        case "ScheduleTableViewController":
            let vc = storyboard.instantiateViewController(withIdentifier: controllerID) as! ScheduleTableViewController
            guard let lessons = dataForVC.0 as? [LessonsModel] else { showError(); return }
            vc.lessons = lessons
            vc.headerDate = dataForVC.1
            parent.navigationController?.pushViewController(vc, animated: true)
        case "EventsTableViewController":
            let vc = storyboard.instantiateViewController(withIdentifier: controllerID) as! EventsViewController
            guard let events = dataForVC.0 as? [EventModel] else { showError(); return }
            vc.events = events
            vc.headerDate = dataForVC.1
            vc.user = dataForVC.2
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
