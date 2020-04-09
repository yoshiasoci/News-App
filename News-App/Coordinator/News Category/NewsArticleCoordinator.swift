//
//  NewsArticleCoordinator.swift
//  News-App
//
//  Created by admin on 4/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class NewsArticleCoordinator: NavigationCoordinator {
    
    var viewController: UIViewController = .init()
    
    var parentCoordinator: NewsCategoryCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start(sourceID: String) {
        let viewModel = NewsArticleViewModel(sourceID: sourceID)
        let viewController = NewsArticleViewController(viewModel: viewModel)
        
        viewModel.detailNewsArticleSubscription = { [weak self] urlArticle in
            self?.detailNewsArticleSubscription(urlArticle: urlArticle)
        }
        
        self.viewController = viewController
        navigationController.pushViewController(self.viewController, animated: false)
    }
    
    func detailNewsArticleSubscription(urlArticle: String) {
        let child = NewsArticleDetailCoordinator(navigationController: navigationController)
        child.parentCoordinator = self.parentCoordinator
        childCoordinators.append(child)
        child.start(urlArticle: urlArticle)
    }
    
}
