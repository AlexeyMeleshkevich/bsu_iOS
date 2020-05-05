//
//  EventsPageViewController.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 30.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class EventsPageViewController: UIPageViewController {
    
    private lazy var imagesViewControllers = [EventImageViewController]()
    private lazy var rootIndex: Int = Int()
    private var currentIndex: Int = Int() {
        didSet(newValue) {
            parent?.title = "\(newValue)/\(imagesViewControllers.count)"
        }
    }
    
    init(images: [UIImage], chosenImageIndex: Int) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.rootIndex = chosenImageIndex
        self.currentIndex = rootIndex
        
        for i in 0..<images.count {
            let vc = EventImageViewController(image: images[i])
            imagesViewControllers.append(vc)
        }
        self.view.backgroundColor = UIColor.black
        subscribeProtocols()
        setViewControllers([imagesViewControllers[rootIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func subscribeProtocols() {
        dataSource = self
        delegate = self
    }
    
    func showError() {
        SVProgressHUD.showError(withStatus: "Ошибка")
    }
}

extension EventsPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard viewController is EventImageViewController else { showError(); return nil }
        
        if currentIndex > 0 {
            let indexVC = imagesViewControllers[currentIndex - 1]
            return indexVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard viewController is EventImageViewController else { showError(); return nil }
        
        if currentIndex < imagesViewControllers.count - 1 {
            let indexVC = imagesViewControllers[currentIndex + 1]
            return indexVC
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed == true else { return }
        if previousViewControllers.last == imagesViewControllers[currentIndex - 1] {
            currentIndex -= 1
        } else {
            currentIndex += 1
        }
        
    }
}
