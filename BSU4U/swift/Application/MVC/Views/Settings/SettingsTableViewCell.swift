//
//  SettingsTableViewCell.swift
//  BSU
//
//  Created by Li on 12/3/19.
//  Copyright © 2019 Alexey Meleshkevich. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.font.withSize(15)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
