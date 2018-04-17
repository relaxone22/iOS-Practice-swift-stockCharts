//
//  AppDelegate.swift
//  stockCharts
//
//  Created by tonyliu on 2018/4/16.
//  Copyright © 2018 mitake. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = BaseNavigationController(rootViewController:ListViewController())
        
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
        return true
    }
}
