//
//  PhotoJournal.swift
//  Photo Journal
//
//  Created by Donkemezuo Raymond Tariladou on 1/14/19.
//  Copyright © 2019 EnProTech Group. All rights reserved.
//

import Foundation

struct PhotoJournal: Codable {
    let imageData: Data
    let createdAt: String
    let description: String
}

