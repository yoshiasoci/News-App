//
//  NewsSourceCollectionViewCell.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NewsSourceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var sourceDescriptionLabel: UILabel!
    @IBOutlet weak var sourceUrlLabel: UILabel!
    
    func populateCell(sourceName: String?, sourceDescription: String?, sourceUrl: String?) {
        sourceNameLabel.text = sourceName!
        sourceDescriptionLabel.text = sourceDescription!
        sourceUrlLabel.text = sourceUrl
    }
    
}
