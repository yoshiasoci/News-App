//
//  NewsCategoryCollectionViewCell.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NewsCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func populateCell(categoryImage: String?, categoryName: String?) {
        categoryImageView.image = UIImage(named: categoryImage!)
        categoryNameLabel.text = categoryName!
    }

    
}
