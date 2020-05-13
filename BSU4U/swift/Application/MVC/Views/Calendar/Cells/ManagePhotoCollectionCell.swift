import Foundation
import UIKit

class ManagePhotoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var managePhoto: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
    }
    
}
