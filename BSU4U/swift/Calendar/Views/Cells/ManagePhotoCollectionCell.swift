//
//  ManagePhotoCollectionCell.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 05.05.2020.
//  Copyright © 2020 Li. All rights reserved.
//

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
