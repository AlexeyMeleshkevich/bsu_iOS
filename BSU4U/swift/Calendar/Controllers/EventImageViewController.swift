//
//  ImageViewController.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 30.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

class EventImageViewController: UIViewController {
    
    private lazy var image: UIImage = UIImage()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor.clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    override func loadView() {
        super.loadView()
        self.view = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
} 
