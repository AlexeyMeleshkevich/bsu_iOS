import Foundation
import UIKit

class PhotosCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
    }
}
