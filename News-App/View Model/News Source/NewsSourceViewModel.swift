//
//  NewsSourceViewModel.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Moya

protocol NewsSourceViewModelable {
    
    //MARK: input
    var cellSourceTapped: PublishSubject<Void> { get }
    var sourceID: BehaviorRelay<String?> { get }
    
    var detailNewsArticleSubscription: ((_ sourceID: String) -> Void)? { get set }
    
    //MARK: output
    var sourceCollectionView: BehaviorRelay<[Source?]> { get }
    var isLoading: PublishSubject<Bool> { get }
    
}

class NewsSourceViewModel: NewsSourceViewModelable {
    
    private let apiServiceProvider = MoyaProvider<ApiNewsService>()
    private let disposeBag = DisposeBag()
    
    var sourceCollectionView = BehaviorRelay<[Source?]>(value: [])
    
    var cellSourceTapped = PublishSubject<Void>()
    var sourceID = BehaviorRelay<String?>(value: "")
    var detailNewsArticleSubscription: ((_ sourceID: String) -> Void)?
    
    var isLoading = PublishSubject<Bool>()
    
    init(category: String) {
        getNewsSource(category: category)
        makeSubscription()
    }
    
    //MARK: - Private Method
    
    private func makeSubscription() {
        cellSourceTapped.subscribe(onNext: { [weak self] _ in
            guard let self =  self else { return }
            self.detailNewsArticleSubscription?(self.sourceID.value!)
    //           print(self.categoryName.value!)
            })
        .disposed(by: disposeBag)
    }
    
    private func getNewsSource(category: String) {
        self.isLoading.onNext(true)
        apiServiceProvider.request(.getNewsSource(apiKey: apiKey, category: category)) { (result) in
            switch result {
                case .failure(let error):
                    print(error)
                    self.isLoading.onNext(false)
                case .success(let response):
                    let sourceData = try? JSONDecoder().decode(SourceResult.self, from: response.data)
                    print(response)
                    self.sourceCollectionView.accept(sourceData?.sources ?? [])
                    self.isLoading.onNext(false)
            }
        }
    }
    
    
}
