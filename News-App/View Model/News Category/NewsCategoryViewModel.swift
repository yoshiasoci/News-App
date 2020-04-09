//
//  NewsCategoryViewModel.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol NewsCategoryViewModelable {
    
    //MARK: input
    var cellCategoryTapped: PublishSubject<Void> { get }
    var categoryName: BehaviorRelay<String?> { get }
    var detailNewsSourceSubscription: ((_ categoryName: String) -> Void)? { get set }
    
    //MARK: output
    var categoryCollectionView: BehaviorRelay<[String?]> { get }
    
}

class NewsCategoryViewModel: NewsCategoryViewModelable {
    
    private let disposeBag = DisposeBag()
    
    var categoryCollectionView = BehaviorRelay<[String?]>(value: [])
    
    var cellCategoryTapped = PublishSubject<Void>()
    var categoryName = BehaviorRelay<String?>(value: "")
    var detailNewsSourceSubscription: ((_ categoryName: String) -> Void)?
    
    init() {
        inputCategory()
        makeSubscription()
    }
    
    //MARK: - Private Method
    
    private func makeSubscription() {
        cellCategoryTapped.subscribe(onNext: { [weak self] _ in
            guard let self =  self else { return }
            self.detailNewsSourceSubscription?(self.categoryName.value!)
//            print(self.categoryName.value!)
            })
        .disposed(by: disposeBag)
    }
    
    private func inputCategory() {
        let category: [String] = ["General", "Business", "Sports", "Entertainment", "Health", "Science", "Technology"]
        categoryCollectionView.accept(category)
    }
}
