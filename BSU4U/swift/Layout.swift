//
//  Layout.swift
//  tableSettigins
//
//  Created by Li on 12/16/19.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraint(attribute : NSLayoutConstraint.Attribute, constant : CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
    let constraint =
        NSLayoutConstraint(item: self, attribute: attribute, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
        self.addConstraint(constraint)
    }
}
