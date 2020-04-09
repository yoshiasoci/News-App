//
//  NewsArticleDetailViewModel.swift
//  News-App
//
//  Created by admin on 4/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol NewsArticleDetailViewModelable {
    
    //MARK: input
    
    
    //MARK: output
    var urlArticle: BehaviorRelay<String?> { get }
}

class NewsArticleDetailViewModel: NewsArticleDetailViewModelable {
    
    private let disposeBag = DisposeBag()
    
    var urlArticle = BehaviorRelay<String?>(value: "")
    
    init(urlArticle: String) {
        self.urlArticle.accept(urlArticle)
    }
    
    //MARK: - Private Method
    
}
