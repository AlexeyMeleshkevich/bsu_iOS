//
//  EventsViewController.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 17.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController {
    
    var headerLabel = UILabel()
    
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
        
        setHeaderLabel()
        headerLabel.text = headerDate
        self.tableView.backgroundColor = UIColor.white
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.photosCellID, for: indexPath) as? EventsTableViewControllerCell else { return UITableViewCell() }
        
        cell.eventTime.text = events[indexPath.row].eventTime
        cell.eventDescription.text = events[indexPath.row].eventFullDescription
        cell.eventName.text = events[indexPath.row].eventName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? EventsTableViewControllerCell else { return }
        cell.subscribeProtocols(self, forRow: indexPath.row)
    }
    
    func setHeaderLabel() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.tableView.frame.width), height: 36))
        headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "Hello"
        header.backgroundColor = UIColor.clear
        headerLabel.textAlignment = .center
        headerLabel.textColor = .lightGray
        header.addSubview(headerLabel)
        headerLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        tableView.tableHeaderView = header
    }
}

extension EventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let counter = events[collectionView.tag].eventImages?.count ?? 0
        return counter
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
        
        let tvCell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as? EventsTableViewControllerCell
        if cell.photo.image == nil {
            tvCell?.setBottomAnchor()
        }
        
        return cell
    }
    
    func validateImages(_ collectionTag: Int, for indexPath: IndexPath) -> UIImage? {
        guard let images = events[collectionTag].eventImages?[indexPath.row] else { return nil}
        return images
    }
}
