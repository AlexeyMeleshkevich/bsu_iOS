//
//  SelectView.swift
//  tableSettigins
//
//  Created by Li on 12/16/19.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class SelectView: UIView {
    let label : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let chevronImage : UIImageView = {
        let imView = UIImageView()
        let im = UIImage(systemName: "chevron.down")
        imView.tintColor = .systemGray
        imView.image = im
        return imView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    
        let stackView = UIStackView(arrangedSubviews: [label, chevronImage])
        stackView.frame = CGRect(x: 20, y: 16, width: frame.width - 40, height: 20)
       
        addSubview(stackView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
