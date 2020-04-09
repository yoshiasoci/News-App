//
//   NewsCategoryCoordinator.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class NewsCategoryCoordinator: NSObject, ParentCoordinator, UINavigationControllerDelegate {
    var viewController: UIViewController = .init()
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        let viewModel = NewsCategoryViewModel()
        let viewController = NewsCategoryViewController(viewModel: viewModel)
        
        viewModel.detailNewsSourceSubscription = { [weak self] category in
            self?.detailNewsSourceSubscription(category: category)
        }
        
        self.viewController = viewController
        navigationController.pushViewController(self.viewController, animated: false)
    }
    
    func detailNewsSourceSubscription(category: String) {
        let child = NewsSourceCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start(category: category)
    }
    
}
