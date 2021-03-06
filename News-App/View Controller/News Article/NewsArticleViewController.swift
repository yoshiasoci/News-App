//
//  NewsArticleViewController.swift
//  News-App
//
//  Created by admin on 4/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class NewsArticleViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate {

    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    var customView = CustomView()
    let loading = SVProgressHUD.self
    
    var newsArticleViewModel: NewsArticleViewModelable
    let disposeBag = DisposeBag()
    
    init(viewModel: NewsArticleViewModelable) {
        self.newsArticleViewModel = viewModel
        super.init(nibName: "NewsArticle", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.show()
        
        if let layout = articleCollectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
        self.articleCollectionView.delegate = self
        
        self.articleCollectionView.register(UINib(nibName: "NewsArticleCell", bundle: nil), forCellWithReuseIdentifier: "NewsArticleCell")
        
        navigationItem.title = "News Article"
        
        makeSearchButton()
        bindData()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.newsArticleViewModel.searchBarText.accept(searchBar.text)
        self.newsArticleViewModel.searchTapped.onNext(())
    }
    
    @objc func showSearchButton(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    //MARK: - Private Method
    
    private func makeSearchButton() {
        //add button in right navigation bar
        let searchColelctionButton = UIBarButtonItem(image: customView.resizeImage(image: UIImage(named: "search")!, targetSize: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(showSearchButton))
        self.navigationItem.rightBarButtonItem  = searchColelctionButton
    }
    
    private func bindData() {
        //Need Loading
        newsArticleViewModel.isLoading
            .subscribe{ [weak self] isLoading in
                guard let self = self else { return }
                if isLoading.element ?? false {
                    self.loading.show()
                } else {
                    self.loading.dismiss()
                }
        }.disposed(by: disposeBag)
        
        //CollectionView
        newsArticleViewModel.articleCollectionView
            .asObservable()
            .bind(to: self.articleCollectionView.rx.items(cellIdentifier: "NewsArticleCell", cellType: NewsArticleCollectionViewCell.self)) { (row,data,cell) in
                cell.populateCell(articleImageUrl: data?.urlToImage, articleTitle: data?.title ?? "", articleUrlMedia: data?.url)
        }.disposed(by: disposeBag)
        
        //Cell Tapped
        self.articleCollectionView.rx.modelSelected(Article.self)
            .subscribe(onNext: { (article) in
                self.newsArticleViewModel.urlArticle.accept(article.url)
                self.newsArticleViewModel.cellArticleTapped.onNext(())
        }).disposed(by: disposeBag)
    }

}

extension NewsArticleViewController: CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width / 2
        return cellWidth
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item >= newsArticleViewModel.articleCollectionView.value.count - 2 {
            self.newsArticleViewModel.endScroll.onNext(())
        }
    }
    
}
