//
//  NewsTopHeadlinesCoordinator.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class NewsTopHeadlinesCoordinator: NSObject, ParentCoordinator, UINavigationControllerDelegate {
    var viewController: UIViewController = .init()
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        let viewModel = NewsTopHeadlinesViewModel()
        let viewController = NewsTopHeadlinesViewController(viewModel: viewModel)
        
        viewModel.detailNewsArticleSubscription = { [weak self] urlArticle in
            self?.detailNewsArticleSubscription(urlArticle: urlArticle)
        }

        self.viewController = viewController
        navigationController.pushViewController(self.viewController, animated: false)
    }
    
    func detailNewsArticleSubscription(urlArticle: String) {
        let child = NewsTopHeadlinesDetailCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start(urlArticle: urlArticle)
    }
    
}
