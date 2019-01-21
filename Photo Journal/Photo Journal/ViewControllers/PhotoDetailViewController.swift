//
//  PhotoDetailViewController.swift
//  Photo Journal
//
//  Created by Donkemezuo Raymond Tariladou on 1/14/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var photoLibrary: UIBarButtonItem!
    
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageDescription: UITextView!
     var photoJournal: PhotoJournal!
    var index = 0
    
    
    private var imagePickerViewController: UIImagePickerController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()
        imageView.contentMode = .scaleToFill
        updateUI()
        title = "Photos"
        setUpDetailVC()
    }
    
    
    private func setUpDetailVC(){
        if let photoJournal = photoJournal{
            imageDescription.text = photoJournal.description
            if let image = UIImage.init(data: photoJournal.imageData) {
                imageView.image = image
            }
            
        } else {
            imageDescription.text = ""
            imageView.image = nil
        }
        
    }
    
    

    private func setupImagePickerViewController(){
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            camera.isEnabled = false
        }
    }
    
    
    private func showImagePickerViewController(){
        present(imagePickerViewController,animated: true, completion: nil)
    }
    
    @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
        
        showImagePickerViewController()
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerViewController.sourceType = .camera
        showImagePickerViewController()
    }
    
    private func savePhoto(image: UIImage){
        
        
        
        
        
    
        if let imageData = image.jpegData(compressionQuality: 0.5){
            guard let imageDescription = imageDescription.text else {fatalError("No description")}
            
            let date = Date()
            let isoDateFormatter =  ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [ .withFullDate,
                                               .withFullTime,
                                               .withInternetDateTime,
                                               .withTimeZone,
                                               .withDashSeparatorInDate]
            
            let imageSetTime = isoDateFormatter.string(from: date)
            
            
            
            let photo = PhotoJournal.init(imageData: imageData, createdAt: imageSetTime, description: imageDescription)
            PhotoJournalModel.appendPhoto(photo: photo)
         
        }
        
        
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let date = Date()
        let isoDateFormatter =  ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [ .withFullDate,
                                           .withFullTime,
                                           .withInternetDateTime,
                                           .withTimeZone,
                                           .withDashSeparatorInDate]
        
        let imageSetTime = isoDateFormatter.string(from: date)
        
        
        
        
        
        if let _ = photoJournal {
            
            if let image = imageView.image, let description = imageDescription.text {
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    let photoJournal = PhotoJournal.init(imageData:imageData, createdAt: imageSetTime, description: description)
                    PhotoJournalModel.appendPhoto(photo: photoJournal)
                }
            }
            
            
            
        
        } else {
        
        if let image = self.imageView.image {
            savePhoto(image: image)
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    }
    
    
    
    private func updateUI(){
        if let photo = PhotoJournalModel.getPhoto(){
            let image = UIImage(data: photo.imageData)
            imageView.image = image
        } else {
            print("Photo does not exist")
        }
    }
    
    
    
    
}

extension PhotoDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           imageView.image = image
            //savePhoto(image: image)
        } else {
            print("No original image")
        }
        dismiss(animated: true, completion: nil)
    }
}
