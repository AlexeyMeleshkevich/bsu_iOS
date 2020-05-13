//
//  UserInfoCell.swift
//  tableSettigins
//
//  Created by Li on 12/5/19.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit


class TestProgressCell: UITableViewCell {
    
    let infoNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0

        lbl.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return lbl
    }()
    
    let Image : UIImageView = {
        let view = UIImageView()
        view.tintColor = UIColor(red: 20.0 / 255.0, green: 78.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
        view.heightAnchor.constraint(equalToConstant: 24).isActive = true
        view.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return view
    }()
    
    var test = false
    
    func updateUI(){
        if test {
            Image.image = UIImage(systemName: "plus")
        }
        else {
            Image.image = UIImage(systemName: "minus")
        }
        
        let stackView = UIStackView(arrangedSubviews: [infoNameLabel, Image])
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.axis = .horizontal
        stackView.frame = contentView.frame
    
        contentView.addSubview(stackView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
