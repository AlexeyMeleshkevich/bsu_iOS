import Foundation
import UIKit

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    
    override func prepareForReuse() {
        eventDescription.superview?.backgroundColor = UIColor.clear
        }
}
