//
//  ViewController.swift
//  Photo Journal
//
//  Created by Donkemezuo Raymond Tariladou on 1/14/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoJournalViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    private var imagePickerViewController: UIImagePickerController!
    
    @IBOutlet weak var addImage: UIBarButtonItem!
    var image: UIImage!
   
    var photoJournals = [PhotoJournal]() {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        setData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setData()
        self.photoCollectionView.reloadData()
        
    }
    
    
    @IBAction func activityButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Options", message: "Select function", preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction.init(title: "Edit", style: .default) { (alert: UIAlertAction!) in
            print("Edit button pressed")
            self.editPhotoJournal(index: sender.tag)
         
            
        }
        
        let save =  UIAlertAction.init(title: "Save", style: .default) { (alert: UIAlertAction!) in
            print("Save button pressed")
            
            
        }
        
        let delete =  UIAlertAction.init(title: "Delete", style: .destructive) { (alert: UIAlertAction!) in
            print("Delete button pressed")
            PhotoJournalModel.delete(index: sender.tag)
            
        }
        
        let cancel =  UIAlertAction.init(title: "Cancel", style: .default) { (alert: UIAlertAction!) in
            print("Cancel button pressed")
           
            
        }
        
        alert.addAction(delete)
        alert.addAction(save)
        alert.addAction(editAction)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func addPhoto(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as? PhotoDetailViewController else {return}
        present(vc, animated: true, completion: nil)
    
    }
    
    
    func setData(){
        self.photoJournals = PhotoJournalModel.getImages()
        
    }
    
    func editPhotoJournal(index: Int){
       
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as? PhotoDetailViewController else {return}
      vc.photoJournal = photoJournals[index]
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
}


extension PhotoJournalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoJournals.count
    }
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCellCollectionViewCell else {return UICollectionViewCell()}
    let photo = photoJournals[indexPath.row]
    cell.image.image = UIImage.init(data: photo.imageData)
    cell.imageDescription.text = photo.description
    cell.time.text = photo.createdAt
    cell.activityButton.tag = indexPath.row
    cell.layer.cornerRadius = 50
    return cell
    }
    
  
}

extension PhotoJournalViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 400, height: 500)
    }
    
}



