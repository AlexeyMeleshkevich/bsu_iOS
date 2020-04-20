//
//  PhotosCollectionCell.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 20.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

class PhotosCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 3
        
        if reuseIdentifier == "C.photo" {
         animateAppear()
        }
    }
    
    func animateAppear() {
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: { [weak self] in
            self?.alpha = 1
        }, completion: nil)
    }
}
