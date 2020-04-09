//
//  NewsArticleDetailCoordinator.swift
//  News-App
//
//  Created by admin on 4/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class NewsArticleDetailCoordinator: NavigationCoordinator {
    
    var viewController: UIViewController = .init()
    
    var parentCoordinator: NewsCategoryCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start(urlArticle: String) {
        let viewModel = NewsArticleDetailViewModel(urlArticle: urlArticle)
        let viewController = NewsArticleDetailViewController(viewModel: viewModel)
        
        self.viewController = viewController
        navigationController.pushViewController(self.viewController, animated: false)
    }
    
}
