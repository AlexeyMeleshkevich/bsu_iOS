//
//  PageViewController.swift
//  ContainerVC
//
//  Created by Li on 12/10/19.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var profile = Profile()
    var infoTableView = InfoPageTableViewController(style: .grouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoTableView.profile = self.profile
        setViewControllers([infoTableView], direction: .forward, animated: false, completion: nil)
    }
    
    func switchTableVC(index: Int) -> UITableViewController{
        switch index {
        case 0: return infoTableView
        case 1: return CreditTableViewController(style: .grouped)
        case 2: return StudyProgressTableViewController(style: .grouped)
        default: return UITableViewController()
            
        }
    }
    
    func nextPageWithIndex(index: Int){
        let controller = switchTableVC(index: index)
        if let info = controller as? InfoPageTableViewController {
            info.profile = self.profile
            setViewControllers([info], direction: .forward, animated: false, completion: nil)
        }
        else {
            setViewControllers([controller], direction: .forward, animated: false, completion: nil)
        }
        
    }
    
}

