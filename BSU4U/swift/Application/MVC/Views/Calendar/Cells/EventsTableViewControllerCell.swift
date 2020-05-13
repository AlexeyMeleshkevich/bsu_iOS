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
        eventDescription.isScrollEnabled = false
        eventDescription.sizeToFit()
        eventDescription.isUserInteractionEnabled = false
        eventDescription.isEditable = false
        isUserInteractionEnabled = true
    }
    
    func setBottomAnchor() {
        eventDescription.removeConstraints(eventDescription.constraints)
        NSLayoutConstraint.activate([
            eventDescription.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            eventDescription.widthAnchor.constraint(equalToConstant: 208.33),
            eventDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            eventDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        ])
        contentView.heightAnchor.constraint(equalToConstant: 50+eventDescription.frame.height).isActive = true
        eventDescription.updateConstraintsIfNeeded()
        
    }
    
    func subscribeProtocols(_ protocols: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        photosCollection.delegate = protocols
        photosCollection.dataSource = protocols
        photosCollection.tag = row
        photosCollection.reloadData()
    }
}
