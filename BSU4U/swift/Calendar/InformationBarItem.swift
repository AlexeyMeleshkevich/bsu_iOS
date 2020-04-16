//
//  InformationBarItem.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 16.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

enum InformationState {
    case events
    case education
}

class InformationBarItem: UIBarButtonItem {
    
    let educationImage = UIImage(named: "education")
    let boltImage = UIImage(systemName: "bolt")
    
    public var currentState: InformationState = .education
    
    func changeState() {
        switch currentState {
        case .education:
            setState(.events)
        case .events:
            setState(.education)
        }
    }
    
//    override init() {
//        super.init()
//    }
    
    override init() {
        super.init()
        
        self.tintColor = UIColor.white
        self.image = boltImage
    }
    
    func setState(_ state: InformationState) {
        switch state {
        case .education:
            self.currentState = state
            self.image = boltImage
        case .events:
            self.currentState = state
            self.image = educationImage
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
