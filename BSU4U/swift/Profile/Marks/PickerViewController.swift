//
//  PickerViewController.swift
//  tableSettigins
//
//  Created by Li on 12/17/19.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let chouseButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(ok(sender:)))
        button.tintColor = Constants.customBlue
        return button
    }()
    
    let cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancel(sender:)))
        button.tintColor = Constants.customBlue
        return button
    }()
    
    
    let semester = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
    }
    
    func updateUI() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        
        picker.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: 183)
        picker.backgroundColor = .white
        
        let navigationItem = UINavigationItem(title: "Семестр")
        navigationItem.rightBarButtonItem = chouseButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationBar.setItems([navigationItem], animated: false)
        
        view.addSubview(navigationBar)
        view.addSubview(picker)
    }
    
    
    @objc func ok(sender: UIBarButtonItem) {
        if let parent =  self.parent as?  StudyProgressTableViewController {
            parent.tableView.isScrollEnabled = true
            // semester[picker.selectedRow(inComponent: 0)]
        }
        view.removeFromSuperview()
        willMove(toParent: self.parent)
        removeFromParent()
    }
    
    @objc func cancel(sender: UIBarButtonItem) {
        if let parent =  self.parent as?  StudyProgressTableViewController {
            parent.tableView.isScrollEnabled = true
        }
        view.removeFromSuperview()
        willMove(toParent: self.parent)
        removeFromParent()
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return semester.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return semester[row]
    }
}
