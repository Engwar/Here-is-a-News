//
//  News.swift
//  Here is a News
//
//  Created by Igor Shelginskiy on 10/10/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct News: Codable {
    var header: String
    var date: Date
    var description: String
    var image: String
}
