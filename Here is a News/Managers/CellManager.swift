//
//  CellManager.swift
//  Here is a News
//
//  Created by Igor Shelginskiy on 10/10/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import Foundation
import UIKit

class CellManager {
    func configure (_ cell: NewsCell, with news: News) {
        cell.header.text = news.header
        cell.date.text = "\(news.date)"
        cell.descript.text = news.descript
    }
}
