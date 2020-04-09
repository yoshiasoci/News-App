//
//  NewsArticleDetailViewController.swift
//  News-App
//
//  Created by admin on 4/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

class NewsArticleDetailViewController: UIViewController, WKNavigationDelegate {
    
    var newsArticleDetailViewModel: NewsArticleDetailViewModelable
    let disposeBag = DisposeBag()
    
    var webView: WKWebView!
    
    init(viewModel: NewsArticleDetailViewModelable) {
        self.newsArticleDetailViewModel = viewModel
        super.init(nibName: "NewsArticleDetail", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: newsArticleDetailViewModel.urlArticle.value!)!
        webView.load(URLRequest(url: url))
          
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        self.navigationItem.rightBarButtonItem = refresh
        
        navigationItem.title = "Detail News Article"

        print(newsArticleDetailViewModel.urlArticle.value!)
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

}
