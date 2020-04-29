//
//  AddEventController.swift
//  BSU4U
//
//  Created by Alexey Meleshkevich on 20.04.2020.
//  Copyright © 2020 Li. All rights reserved.
//

import Foundation
import UIKit

class ManageEventController: UIViewController {
    
    @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var newEventLabel: UILabel!
    @IBOutlet weak var takePhotoEvent: UIButton!
    @IBOutlet weak var eventTopic: UILabel!
    @IBOutlet weak var topicField: UITextField!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var photosCollection: UICollectionView!
    
    public enum ControllerState {
        case edit
        case add
    }
    
    lazy var state: ControllerState = .add
    lazy var photos = [UIImage?]()
    
    var data: EventModel! {
        didSet(newValue) {
            self.bindData(data: newValue)
        }
    }
    
    init(state: ControllerState, data: EventModel?) {
        super.init(nibName: nil, bundle: nil)
        
        switch state {
        case .add:
            break
        case .edit:
            guard let data = data else {
                let wrongAlert = UIAlertController(title: "Ошибка", message: "Данные не получены", preferredStyle: .alert)
                wrongAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action) in
                    self?.navigationController?.popViewController(animated: true)
                }))
                self.present(wrongAlert, animated: true, completion: nil)
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
    }
    
    func setUI() {
        setTakePhotoEvent()
        setEventDescription()
        setAddEventButton()
        
        photosCollection.delegate = self
        photosCollection.dataSource = self
    }
    
    func setTakePhotoEvent() {
        takePhotoEvent.imageView?.image = UIImage(systemName: "camera")
    }
    
    func setEventDescription() {
        eventDescription.delegate = self
        eventDescription.layer.borderColor = UIColor.lightGray.cgColor
        eventDescription.layer.cornerRadius = 5
    }
    
    func setAddEventButton() {
        addEventButton.layer.cornerRadius = 10
    }
    
    func bindData(data: EventModel) {
        bindImages(imagesArray: data.eventImages!)
        self.addEventButton.titleLabel?.text = "Сохранить"
        self.newEventLabel.text = "Редактировать"
        self.topicField.text = data.eventName
        self.eventDescription.text = data.eventDescription
    }
    
    func bindImages(imagesArray: [UIImage]) {
        guard let images = data.eventImages else { return }
        self.photos = images
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addEvent(_ sender: Any) {
        
    }
}

extension ManageEventController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = UIColor.black
    }
}

extension ManageEventController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.photos.append(image)
        self.photosCollection.reloadData()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photosCellID, for: indexPath) as? PhotosCollectionCell else { return UICollectionViewCell() }
        
        cell.photo.image = photos[indexPath.row]
        
        return cell
    }
}
