//
//  NewsSourceCoordinator.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class NewsSourceCoordinator: NavigationCoordinator {
    
    var viewController: UIViewController = .init()
    
    var parentCoordinator: NewsCategoryCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start(category: String) {
        let viewModel = NewsSourceViewModel(category: category)
        let viewController = NewsSourceViewController(viewModel: viewModel)
        
        viewModel.detailNewsArticleSubscription = { [weak self] sourceID in
            self?.detailNewsArticleSubscription(sourceID: sourceID)
        }
        
        self.viewController = viewController
        navigationController.pushViewController(self.viewController, animated: false)
    }
    
    func detailNewsArticleSubscription(sourceID: String) {
        let child = NewsArticleCoordinator(navigationController: navigationController)
        child.parentCoordinator = self.parentCoordinator
        childCoordinators.append(child)
        child.start(sourceID: sourceID)
    }
    
}
