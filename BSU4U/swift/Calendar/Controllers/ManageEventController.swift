//
//  AddEventController.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 20.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class ManageEventController: UIViewController {
    
    @IBOutlet var addEventButton: UIButton!
    @IBOutlet var newEventLabel: UILabel!
    @IBOutlet var takePhotoEvent: UIButton!
    @IBOutlet var eventTopic: UILabel!
    @IBOutlet var topicField: UITextField!
    @IBOutlet var eventDescriptionLabel: UILabel!
    @IBOutlet var eventDescription: UITextView!
    @IBOutlet var photosCollection: UICollectionView!
    var blurViewWindow: UIVisualEffectView!
    
    public enum ControllerState {
        case edit
        case add
    }
    
    var user: AccessType!
    
    lazy var state: ControllerState = .edit
    lazy var photos = [UIImage]()
    
    var data: EventModel! {
        didSet(newValue) {
            self.bindData(data: newValue)
        }
    }
    
    init?(coder: NSCoder, state: ControllerState, data: EventModel?, user: AccessType) {
        super.init(coder: coder)
        self.user = user
        self.state = state
        
        switch state {
        case .add:
            break
            
        case .edit:
            guard let data = data else {
                let wrongAlert = UIAlertController(title: "Ошибка", message: "Данные не получены", preferredStyle: .alert)
                wrongAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action) in
                    self?.navigationController?.popViewController(animated: true)
                }))
                parent?.present(wrongAlert, animated: true, completion: nil)
                break }
            
            self.data = data
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        if self.state == ControllerState.edit {
            bindData(data: data)
        }
    }
    
    func setUI() {
        setTakePhotoEvent()
        setEventDescription()
        setAddEventButton()
        setTopicField()
        
        photosCollection.delegate = self
        photosCollection.dataSource = self
    }
    
    func setTopicField() {
        topicField.layer.borderColor = UIColor.lightGray.cgColor
        topicField.layer.borderWidth = 1
        topicField.layer.cornerRadius = 5
    }
    
    func setTakePhotoEvent() {
        takePhotoEvent.imageView?.contentMode = .scaleAspectFill
        UIView.animate(withDuration: 0.1) {
            self.takePhotoEvent.imageView?.transform = CGAffineTransform(scaleX: 3, y: 3)
        }
    }
    
    func setEventDescription() {
        eventDescription.delegate = self
        
        eventDescription.isScrollEnabled = false
        eventDescription.sizeToFit()
        eventDescription.layer.borderColor = UIColor.lightGray.cgColor
        eventDescription.layer.borderWidth = 1
        eventDescription.layer.cornerRadius = 5
    }
    
    func setAddEventButton() {
        addEventButton.layer.cornerRadius = 10
    }
    
    func bindData(data: EventModel) {
        bindImages(imagesArray: data.eventImages!)
        self.newEventLabel.text = "Редактировать"
        self.addEventButton.setTitle("Сохранить", for: .normal)
        self.topicField.text = data.eventName
        self.eventDescription.text = data.eventFullDescription
        eventDescription.textColor = UIColor.black
    }
    
    func bindImages(imagesArray: [UIImage]) {
        guard let images = data.eventImages else { return }
        self.photos = images
        photosCollection.reloadData()
    }
    
    func showError() {
        SVProgressHUD.showError(withStatus: "Ошибка")
    }
    
    func blurView() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurViewWindow = UIVisualEffectView(effect: blurEffect)
        blurViewWindow.alpha = 0
        blurViewWindow.frame = self.view.bounds
        view.addSubview(blurViewWindow)
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.blurViewWindow.alpha = 1
        }
    }
    
    func dismissBlur(alert: UIAlertAction!) {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.blurViewWindow.alpha = 0
            self?.blurViewWindow.removeFromSuperview()
        }
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        blurView()
        
        let alert = UIAlertController(title: "Добавить фото", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { (action) in
            UIImagePickerController.isSourceTypeAvailable(.camera)
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Библиотека", style: .default, handler: { (action) in
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: dismissBlur))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addEvent(_ sender: Any) {
        
    }
}

extension ManageEventController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = UIColor.black
        
        let placeholder = "Введите описание"
        if textView.text == placeholder {
            textView.text = ""
        }
    }
}

extension ManageEventController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        var row = photosCollection.numberOfItems(inSection: 0)
        if row == 0 {
            row = 0
        } else {
            row += 1
        }
        let indexPath = IndexPath(row: row, section: 0)
        
        dismiss(animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.photos.append(image)
                self?.photosCollection.insertItems(at: [indexPath])
                self?.photosCollection.reloadData()
            }
        }
        dismissBlur(alert: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissBlur(alert: nil)
        dismiss(animated: true, completion: nil)
    }
}

extension ManageEventController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.managePhotosCellID, for: indexPath) as? ManagePhotoCollectionCell else { showError(); return UICollectionViewCell() }
        
        cell.managePhoto.image = photos[indexPath.row]
//
//        let deleteButton = UIButton(type: .close)
//        deleteButton.tintColor = UIColor.white
//        cell.managePhoto.addSubview(deleteButton)
//        let frame = CGRect(x: 75, y: 30, width: 40, height: 40)
//        deleteButton.frame = frame
//        deleteButton.layer.cornerRadius = deleteButton.frame.height/2
        
        return cell
    }
}
