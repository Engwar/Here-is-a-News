//
//  NewsCell.swift
//  Here is a News
//
//  Created by Igor Shelginskiy on 10/13/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var descript: UITextView!
    @IBOutlet weak var img: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
