//
//  EventsTableViewControllerCell.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 28.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

class EventsTableViewControllerCell: UITableViewCell {
    
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var photosCollection: UICollectionView!
    
    override func prepareForReuse() {
        eventDescription.superview?.backgroundColor = UIColor.clear
        eventDescription.backgroundColor = UIColor.clear
        photosCollection.backgroundColor = UIColor.clear
        eventDescription.isEditable = false
        isUserInteractionEnabled = true
        
    }
    
    func setBottomAnchor() {
        bottomAnchor.constraint(equalTo: eventDescription.bottomAnchor, constant: 10).isActive = true
    }
    
    func subscribeProtocols(_ protocols: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        photosCollection.delegate = protocols
        photosCollection.dataSource = protocols
        photosCollection.tag = row
        photosCollection.reloadData()
    }
}
