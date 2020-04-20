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
    
    lazy var photos = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        setTakePhotoEvent()
        setEventDescription()
        
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
