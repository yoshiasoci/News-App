//
//  AppDelegate.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: MainTabBarCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = .init(frame: UIScreen.main.bounds)
        coordinator = .init(window: window)
        window?.makeKeyAndVisible()
        coordinator.start()
        
        return true
    }


}

