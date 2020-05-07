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
    @IBOutlet var timeButton: UIButton!
    var blurViewWindow: UIVisualEffectView!
    
//    public enum ControllerState {
//        case edit
//        case add
//    }
    
    weak var delegate: EventsViewControllerDelegate?
    
    var user: AccessType!
    
    lazy var state: ControllerState = .edit
    lazy var photos = [UIImage]()
    lazy var chosenCell: IndexPath? = IndexPath()
    
    var data: EventModel!
    
    init?(coder: NSCoder, state: ControllerState, data: EventModel?, user: AccessType, indexPath: IndexPath?) {
        super.init(coder: coder)
        self.user = user
        self.state = state
        self.chosenCell = indexPath
        
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
        photosCollection.reloadData()
        photosCollection.backgroundColor = UIColor.clear
        self.newEventLabel.adjustsFontSizeToFitWidth = true
        timeButton.layer.cornerRadius = 6
        timeButton.layer.borderWidth = 1
        timeButton.layer.borderColor = UIColor.lightGray.cgColor
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
        self.newEventLabel.text = "Редактировать"
        self.addEventButton.setTitle("Сохранить", for: .normal)
        self.timeButton.setTitle(data.eventTime, for: .normal)
        self.topicField.text = data.eventName
        self.eventDescription.text = data.eventFullDescription
        eventDescription.textColor = UIColor.black
        guard let images = data.eventImages else { return }
        self.photos = images
        bindImages(imagesArray: images)
    }
    
    func bindImages(imagesArray: [UIImage]) {
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
    
    func validateField(message: String) {
        blurView()
        let alert = UIAlertController(title: "Все поля должны быть заполнены.", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: dismissBlur(alert:)))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkFields() -> Bool {
        if eventDescription.text.isEmpty {
            validateField(message: "Введите описание")
            return false
        }
        if topicField.text!.isEmpty || eventDescription.text == "Введите описание" {
            validateField(message: "Введите тему")
            return false
        }
        
        if timeButton.titleLabel!.text!.isEmpty || checkTimeButton() == false {
            validateField(message: "Введите время")
            return false
        }
        
        return true
    }
    
    func checkTimeButton() -> Bool {
        if timeButton.titleLabel!.text!.isEmpty {
            return false
        }
        
        guard let data = data else { return false }
        
        guard let taim = data.eventTime else { return false }
        
        if taim.isEmpty {
            return false
        }
        return true
    }
    
    @IBAction func addEvent(_ sender: Any) {
        guard let fullDescription = eventDescription.text else { validateField(message: "Введите описание"); return }
        guard let name = topicField.text else {validateField(message: "Введите тему"); return}
        guard let time = timeButton.titleLabel?.text else { return }
        
        if checkFields() == false {
            return
        }
        
        switch state {
        case .add:
            guard let cell = chosenCell else { return }
            data = EventModel(eventName: name, eventTime: time, eventDescription: nil, eventFullDescription: fullDescription, eventImages: photos)
            guard let data = data else { return }
            
            self.dismiss(animated: true) { [weak self] in
                self?.delegate?.update(with: data, indexPath: cell, state: self!.state)
            }
        case .edit:
            self.data.eventFullDescription = fullDescription
            self.data.eventName = name
            self.data.eventImages = photos
            self.data.eventTime = time
            
            guard let data = data else { return }
            guard let cell = chosenCell else { return }
            
            self.dismiss(animated: true) { [weak self] in
                self?.delegate?.update(with: data, indexPath: cell, state: self!.state)
            }
        }
    }
    
    func timeAlert() {
        if data != nil && data.eventTime != nil {
            let timeAlert = UIAlertController(title: "Время события", message: data.eventTime, preferredStyle: .alert)
            timeAlert.addTextField(configurationHandler: { (tf) in
                tf.placeholder = "Введите время"
            })
            timeAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                guard let time = timeAlert.textFields![0].text else { return }
                if time.isEmpty && time.count <= 5 && !time.contains(":") {
                    return
                }
                self.data.eventTime = time
                self.timeButton.setTitle(time, for: .normal)
            }))
            self.present(timeAlert, animated: true, completion: nil)
        } else {
            let timeAlert = UIAlertController(title: "Время события", message: "Введите время", preferredStyle: .alert)
            timeAlert.addTextField(configurationHandler: { (tf) in
                tf.placeholder = "Введите время"
            })
            timeAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                guard let time = timeAlert.textFields![0].text else { return }
                if time.isEmpty && time.count <= 5 && !time.contains(":") {
                    return
                }
                self.data = EventModel(eventName: nil, eventTime: time, eventDescription: nil, eventFullDescription: nil, eventImages: nil)
                self.data.eventTime = time
                self.timeButton.setTitle(time, for: .normal)
            }))
            self.present(timeAlert, animated: true, completion: nil)
        }
    }
    @IBAction func pickTime(_ sender: Any) {
        timeAlert()
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
        
        let row = photos.count
        
        let indexPath = IndexPath(row: row, section: 0)
        
        dismiss(animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
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
        
        let deleteButton = UIButton()
        deleteButton.setBackgroundImage(UIImage(systemName: "xmark.circle"), for: .normal)
        deleteButton.tintColor = UIColor.white
        cell.managePhoto.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.rightAnchor.constraint(equalTo: cell.managePhoto.rightAnchor, constant: -5),
            deleteButton.topAnchor.constraint(equalTo: cell.managePhoto.topAnchor, constant: 5),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        deleteButton.layer.cornerRadius = deleteButton.frame.height/2
        deleteButton.tag = indexPath.row
        deleteButton.addTarget(self, action: #selector(deletePhoto(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func deletePhoto(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        photosCollection.deleteItems(at: [indexPath])
        photos.remove(at: sender.tag)
        if state == ControllerState.edit {
            data.eventImages?.remove(at: sender.tag)
        }
        photosCollection.reloadData()
    }
}
