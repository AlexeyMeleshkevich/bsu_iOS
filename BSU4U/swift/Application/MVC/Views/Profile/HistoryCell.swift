//
//  HistoryCell.swift
//  tableSettigins
//
//  Created by Li on 12/11/19.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    let typeLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    let amountLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        updateUI()
    }
    
    func updateUI(){
        let stackView = UIStackView(arrangedSubviews: [typeLabel, amountLabel, dateLabel])
//        stackView.distribution = .equalCentering
//        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.frame = contentView.frame
        
        contentView.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
