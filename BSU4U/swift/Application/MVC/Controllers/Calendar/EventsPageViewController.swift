import Foundation
import UIKit
import SVProgressHUD

class EventsPageViewController: UIPageViewController {
    
    private lazy var total: Int = 0
    private lazy var rootIndex: Int = Int()
    
    var images = [UIImage]()
    
    init(images: [UIImage], chosenImageIndex: Int) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.rootIndex = chosenImageIndex
        self.total = images.count - 1
        self.images = images
        
        self.view.backgroundColor = UIColor.black
        let rootViewController = EventImageViewController(image: images[rootIndex], pageIndex: rootIndex)
        setViewControllers([rootViewController], direction: .forward, animated: true, completion: nil)
        
        subscribeProtocols()
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
        
        var index = (viewController as! EventImageViewController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
          return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! EventImageViewController).pageIndex
        
        if index == NSNotFound || index == self.total {
          return nil
        }
        
        index += 1
        
        return viewControllerAtIndex(index: index)
    }
    
    func viewControllerAtIndex(index: Int) -> EventImageViewController?
    {
      if self.total == 0 || index > self.total
      {
        return nil
      }
      
      let vc = EventImageViewController(image: images[index], pageIndex: index)
      
      return vc
    }
}
