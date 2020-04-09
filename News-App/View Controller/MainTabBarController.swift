//
//  MainTabBarController.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    private let viewModel: MainTabBarViewModel
    init(viewModel: MainTabBarViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTabBarItems() {
        viewModel.viewControllers.enumerated().forEach {
            $0.element.tabBarItem = viewModel.tabBarItems[$0.offset]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
        self.viewControllers = viewModel.viewControllers
    }

}
