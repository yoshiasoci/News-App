//
//  NewsArticleCollectionViewCell.swift
//  News-App
//
//  Created by admin on 4/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NewsArticleCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var articleImageView: CustomImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    var articleUrl: String?
    
    func populateCell(articleImageUrl: String?, articleTitle: String?, articleUrlMedia: String?) {
        
        articleImageView.ImageViewLoading(mediaUrl: articleImageUrl ?? "")
        articleTitleLabel.text = articleTitle!
        articleUrl = articleUrlMedia!
    }
    
    override func prepareForReuse() {
        self.articleImageView.image = nil
        self.articleTitleLabel.text = nil
    }
    
    
}
