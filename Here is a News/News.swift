//
//  News.swift
//  Here is a News
//
//  Created by Igor Shelginskiy on 10/10/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct Articles: Codable {
    var articles = [News]()
}

struct News: Codable {
        var title: String?
        var publishedAt: Date
        var author: String?
        var urlToImage: String?
        
        enum CodingKeys: String, CodingKey {
            case title, publishedAt, urlToImage, author
    }
}
