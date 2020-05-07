//
//  EventsViewController.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 17.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import UIKit
import SVProgressHUD

enum ControllerState {
    case edit
    case add
}

protocol EventsViewControllerDelegate: class {
    func update(with data: EventModel, indexPath: IndexPath, state: ControllerState)
}

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EventsViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var headerLabel = UILabel()
    var user: AccessType!
    
    var events = [EventModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    var headerDate: String = "" {
        didSet(date) {
            self.headerLabel.text = date
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Расписание событий"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentManageViewController))
        tableView.delegate = self
        tableView.dataSource = self
        
        setHeaderLabel()
        headerLabel.text = headerDate
        self.tableView.backgroundColor = UIColor.white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch user {
        case .admin:
            tableView.deselectRow(at: indexPath, animated: true)
            let event = events[indexPath.row]
//            presentManageViewControllerEdit(data: event)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ManageEventController", creator: {
                coder1 in
                return ManageEventController(coder: coder1, state: .edit, data: event, user: self.user,indexPath: indexPath)
            })
            
            self.present(vc, animated: true, completion: {
                vc.delegate = self
            })
        case .user:
            tableView.deselectRow(at: indexPath, animated: true)
        case .none:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard user == AccessType.admin else { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch events[indexPath.row].eventImages?.count {
//        case nil:
//            guard let cell = tableView.cellForRow(at: indexPath) as? EventsTableViewControllerCell else { return 170 }
//            cell.setBottomAnchor()
//            return 200
//        default:
//            return 300
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.photosCellID, for: indexPath) as? EventsTableViewControllerCell else { return UITableViewCell() }
        cell.subscribeProtocols(self, forRow: indexPath.row)
        
        cell.eventTime.text = events[indexPath.row].eventTime
        cell.eventDescription.text = events[indexPath.row].eventFullDescription
        cell.eventName.text = events[indexPath.row].eventName
        if events[indexPath.row].eventImages?.count == nil || events[indexPath.row].eventImages?.count == 0 {
            cell.setBottomAnchor()
            cell.heightAnchor.constraint(equalToConstant: 50+cell.eventDescription.frame.height).isActive = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let animation = makeSlideIn(duration: 0.5, delayFactor: 0.1)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard user == AccessType.admin else { return }
        
        if editingStyle == .delete {
            
            self.events.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
    }
    
    func setHeaderLabel() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: 36))
        headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "Hello"
        header.backgroundColor = UIColor.clear
        headerLabel.textAlignment = .center
        headerLabel.textColor = .lightGray
        header.addSubview(headerLabel)
        headerLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        tableView.tableHeaderView = header
    }
    
    func showError() {
        SVProgressHUD.showError(withStatus: "Ошибка")
    }
    
    func update(with data: EventModel, indexPath: IndexPath, state: ControllerState) {
        switch state {
        case .add:
            events.append(data)
            let ip = IndexPath(row: self.events.count + 1, section: 0)
            tableView.insertRows(at: [ip], with: .automatic)
//            tableView.reloadData()
        case .edit:
            events[indexPath.row] = data
            tableView.reloadRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func presentManageViewControllerEdit(data: EventModel, at path: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ManageEventController", creator: {
            coder in
            return ManageEventController(coder: coder, state: .edit, data: data, user: self.user, indexPath: path)
        })
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func presentManageViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ManageEventController", creator: {
            coder in
            return ManageEventController(coder: coder, state: .add, data: nil, user: self.user, indexPath: IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0))
        })
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func makeSlideIn(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
            
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}

extension EventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events[collectionView.tag].eventImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 1) {
            cell.alpha = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.eventsPhotosCellID, for: indexPath) as? PhotosCollectionCell else { return UICollectionViewCell() }
        
        cell.photo.image = validateImages(collectionView.tag, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let images = events[collectionView.tag].eventImages else { showError(); return}
        print(indexPath.row)
        
        presentPhotos(with: images, indexPath: indexPath)
    }
    
    func setUIStateForPhoto() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.tabBarController?.tabBar.isHidden = true
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: #selector(dismissPhoto))
        //        let closeButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(dismissPhoto))
        self.navigationItem.rightBarButtonItem = closeButton
        self.navigationItem.hidesBackButton = true
        
    }
    
    @objc func dismissPhoto(sender: UIView) {
        title = "Расписание событий"
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = Constants.customBlue
        self.navigationItem.rightBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentManageViewController))
        self.navigationItem.hidesBackButton = false
        UIView.animate(withDuration: 0.3) {
                self.children[0].view.alpha = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.removeChild()
        }
    }
    
    func presentPhotos(with images: [UIImage], indexPath: IndexPath) {
        let imagesVC = EventsPageViewController(images: images, chosenImageIndex: indexPath.row)
        
        guard let imagesView = imagesVC.view else { showError(); return }
        imagesView.frame = CGRect.zero
        imagesView.center = self.view.center
        
        setUIStateForPhoto()
        
        self.addChild(imagesVC)
        self.title = "Фотографии события"
        
        let slideGestureTop = UISwipeGestureRecognizer(target: self, action: #selector(dismissPhoto))
        slideGestureTop.direction = .down
        
        let slideGestureDowm = UISwipeGestureRecognizer(target: self, action: #selector(dismissPhoto))
        slideGestureDowm.direction = .up
        
        imagesVC.view.addGestureRecognizer(slideGestureDowm)
        imagesVC.view.addGestureRecognizer(slideGestureTop)
        
        UIView.animate(withDuration: 0.3) {
            self.view.addSubview(imagesView)
            imagesView.frame = self.view.bounds
        }
        imagesVC.didMove(toParent: self)
    }
    
    func validateImages(_ collectionTag: Int, for indexPath: IndexPath) -> UIImage? {
        guard let images = events[collectionTag].eventImages?[indexPath.row] else { return nil}
        return images
    }
}

extension UIViewController {
    
    func removeChild() {
        self.children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
}
