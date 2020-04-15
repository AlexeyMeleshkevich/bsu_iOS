//
//  HeaderHistoryView.swift
//  tableSettigins
//
//  Created by Li on 12/12/19.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class HeaderHistoryView: UIView {
    
    
    let typeLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.text = "Платеж"
        return lbl
    }()
    let amountLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.text = "Сумма оплаты"
        return lbl
    }()
    
    let dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .right
        lbl.numberOfLines = 1
        lbl.text = "Дата"
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [typeLabel, amountLabel, dateLabel])
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        stackView.axis = .horizontal
                
        let blackLine = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: frame.width , height: 1)))
        blackLine.backgroundColor = .black
        
        blackLine.addConstraint(attribute : .width,  constant: frame.width)
        blackLine.addConstraint(attribute : .height,  constant: 1)
        stackView.addConstraint(attribute: .width, constant: frame.width)
        
        let fullStackView = UIStackView(arrangedSubviews: [stackView, blackLine])
        fullStackView.axis = .vertical
        fullStackView.distribution = .equalCentering
        fullStackView.alignment = .center
        fullStackView.spacing = 10
        fullStackView.frame = CGRect(x: frame.minX, y: frame.midY - 10, width: frame.width, height: frame.height / 2 + 10)
        
        addSubview(fullStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
