//
//  MainTabBarCoordinator.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarCoordinator: Coordinator {
    var viewController: UIViewController = .init()
    
    var customView = CustomView()
    
    private let newsCategoryCoordinator = NewsCategoryCoordinator()
    private let newsTopHeadlinesCoordinator = NewsTopHeadlinesCoordinator()
    
    weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        
        newsCategoryCoordinator.start()
        newsTopHeadlinesCoordinator.start()
        
        
        let viewControllers = [newsCategoryCoordinator.navigationController, newsTopHeadlinesCoordinator.navigationController]
        
        let tabBarItems: [UITabBarItem] = [
            UITabBarItem(title: "News Category", image: customView.resizeImage(image: UIImage(named: "category")!, targetSize: CGSize(width: 30, height: 30)), tag: 1),
            UITabBarItem(title: "Top Headlines", image: customView.resizeImage(image: UIImage(named: "headline")!, targetSize: CGSize(width: 30, height: 30)), tag: 2)
        ]
        
        let viewModel = MainTabBarViewModel(
            viewControllers: viewControllers,
            tabBarItems: tabBarItems
        )
        
        self.viewController = MainTabBarController(viewModel: viewModel)
        window?.rootViewController = self.viewController
    }
    
}
