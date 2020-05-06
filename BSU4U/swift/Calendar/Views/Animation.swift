//
//  Animation.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 06.05.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

class Animator {
    private var hasAnimatedAllCells = false
    private let animation: Animation
    
    init(animation: @escaping Animation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }

        animation(cell, indexPath, tableView)

        hasAnimatedAllCells = tableView.visibleCells.contains(cell)
    }
}
