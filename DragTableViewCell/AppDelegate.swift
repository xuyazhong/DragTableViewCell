//
//  AppDelegate.swift
//  DragTableViewCell
//
//  Created by xuyazhong on 2020/1/14.
//  Copyright © 2020 xyz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.frame  = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        window?.rootViewController = Daily()

        return true
    }

}

