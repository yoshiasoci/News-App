//
//  Coordinator.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var viewController:  UIViewController { get set }
}

protocol ParentCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }
}

protocol NavigationCoordinator: ParentCoordinator {
    var navigationController: UINavigationController { get set }
}

extension NavigationCoordinator {
    var viewController: UIViewController {
        navigationController.viewControllers.first ?? UIViewController()
    }
}
