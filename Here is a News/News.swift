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
    var descript: String
    var img: URL
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        header = try valueContainer.decode(String.self, forKey: .header)
        date = try valueContainer.decode(Date.self, forKey: .date)
        descript = try valueContainer.decode(String.self, forKey: .descript)
        img = try valueContainer.decode(URL.self, forKey: .img)
    }
    
    enum CodingKeys: String, CodingKey {
        case header = "author"
        case date = "publishedAt"
        case descript = "description"
        case img = "urlToImage"
    }
}
