//
//  PhotoJournalModel.swift
//  Photo Journal
//
//  Created by Donkemezuo Raymond Tariladou on 1/14/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation

final class PhotoJournalModel {
    static let filename = "PhotoList.plist"
    private init(){}
    private static var allImages = [PhotoJournal]()

    
    static func savePhotos() {
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(allImages)
        try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Encountered unexpected error \(error) while encoding property list")
        }
        
}

    static func getImages() -> [PhotoJournal]{
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename).path
        if  FileManager.default.fileExists(atPath: path){
        if let data = FileManager.default.contents(atPath: path){
            do {
                allImages = try PropertyListDecoder().decode([PhotoJournal].self, from: data)
            } catch {
                
                print("Property list decoding error: \(error)")
            }
        } else {
            print("There is no data ")
        }
        } else {
            print("File \(filename)  does not exist")
        }
        return allImages
    }
    static func appendPhoto(photo: PhotoJournal){
        
        allImages.append(photo)
        savePhotos()
    }
    
    
    
    
    
    static func delete(index:Int){
        allImages.remove(at: index)
        savePhotos()
    }
    
    
    static func getPhoto() -> PhotoJournal? {
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename).path
        var photo:PhotoJournal?
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    photo = try PropertyListDecoder().decode(PhotoJournal.self, from: data)
                } catch {
                    print("Encountered unexpected error \(error) while decoding property list")
                }
            } else {
                print("Data is nil on getPhoto function")
            }
        } else {
            print("The \(filename) file does not exist")
        }
        
        return photo
    }
    
    
}
