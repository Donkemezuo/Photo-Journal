//
//  DataPersistenceManager.swift
//  Photo Journal
//
//  Created by Donkemezuo Raymond Tariladou on 1/14/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation

final class DataPersistenceManager{
    static func documentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
    }
    
    static func filePathToDocumentsDirectory(filename: String) -> URL {
        return documentDirectory().appendingPathComponent(filename)
    }
}
