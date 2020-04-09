//
//  NewsArticleViewModel.swift
//  News-App
//
//  Created by admin on 4/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Moya

protocol NewsArticleViewModelable {
    
    //MARK: input
    var cellArticleTapped: PublishSubject<Void> { get }
    var searchTapped: PublishSubject<Void> { get }
    var searchBarText: BehaviorRelay<String?> { get }
    var endScroll: PublishSubject<Void> { get }
    
    var urlArticle: BehaviorRelay<String?> { get }
    var detailNewsArticleSubscription: ((_ urlArticle: String) -> Void)? { get set }
    
    //MARK: output
    var articleCollectionView: BehaviorRelay<[Article?]> { get }
    var isLoading: PublishSubject<Bool> { get }
    
}

class NewsArticleViewModel: NewsArticleViewModelable {
    
    private let apiServiceProvider = MoyaProvider<ApiNewsService>()
    private let disposeBag = DisposeBag()
    
    var urlArticle = BehaviorRelay<String?>(value: "")
    var detailNewsArticleSubscription: ((_ urlArticle: String) -> Void)?
    
    var articleCollectionView = BehaviorRelay<[Article?]>(value: [])
    
    var cellArticleTapped = PublishSubject<Void>()
    var searchTapped = PublishSubject<Void>()
    let searchBarText = BehaviorRelay<String?>(value: "")
    var endScroll = PublishSubject<Void>()
    var stopLoad = BehaviorRelay<Bool>(value: false)
    
    let pageArticle = BehaviorRelay<Int?>(value: 1)
    var isSearchArticle = BehaviorRelay<Bool>(value: false)
    var sourceID = BehaviorRelay<String?>(value: "")
    
    var isLoading = PublishSubject<Bool>()
    
    init(sourceID: String) {
        self.sourceID.accept(sourceID)
        getNewsArticle(page: 1)
        makeSubscription()
    }
    
    //MARK: - Private Method
    private func makeSubscription() {
        searchTapped.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.articleCollectionView.accept([])
            self.pageArticle.accept(0)
            self.isSearchArticle.accept(true)
            self.stopLoad.accept(false)
            self.loadPhoto()
            })
        .disposed(by: disposeBag)
        
        cellArticleTapped.subscribe(onNext: { [weak self] _ in
            guard let self =  self else { return }
            self.detailNewsArticleSubscription?(self.urlArticle.value!)
            })
        .disposed(by: disposeBag)
        
        endScroll.subscribe(onNext : { [weak self] _ in
            guard let self = self else { return }
            self.loadPhoto()
            })
        .disposed(by: disposeBag)
    }
    
    private func getNewsArticle(page: Int) {
        self.isLoading.onNext(true)
        self.isSearchArticle.accept(false)
        apiServiceProvider.request(.getNewsArticle(apiKey: apiKey, sources: sourceID.value!, page: page)) { (result) in
            switch result {
                case .failure(let error):
                    print(error)
                    self.isLoading.onNext(false)
                case .success(let response):
                    let articleData = try? JSONDecoder().decode(ArticleResult.self, from: response.data)
                    print(response)
                    if articleData?.articles == nil {
                        self.stopLoad.accept(true)
                    }
                    self.articleCollectionView.accept(self.articleCollectionView.value + (articleData?.articles ?? []))
                    self.isLoading.onNext(false)
            }
        }
    }
    
    private func searchNewsArticle(query: String, page: Int) {
        self.isLoading.onNext(true)
        apiServiceProvider.request(.searchNewsArticle(apiKey: apiKey, query: query, page: page)) { (result) in
            switch result {
                case .failure(let error):
                    print(error)
                    self.isLoading.onNext(false)
                case .success(let response):
                    let articleData = try? JSONDecoder().decode(ArticleResult.self, from: response.data)
                    print(response)
                    if articleData?.articles == nil {
                        self.stopLoad.accept(true)
                    }
                    self.articleCollectionView.accept(self.articleCollectionView.value + (articleData?.articles ?? []))
                    self.isLoading.onNext(false)
            }
        }
    }
    
    private func loadPhoto() {
        if stopLoad.value == false {
            if isSearchArticle.value == true {
                self.searchNewsArticle(query: self.searchBarText.value!, page: self.pageArticle.value! + 1)
                self.pageArticle.accept(self.pageArticle.value! + 1)
            } else {
                getNewsArticle(page: self.pageArticle.value! + 1)
                self.pageArticle.accept(self.pageArticle.value! + 1)
            }
        }
    }
    
}
