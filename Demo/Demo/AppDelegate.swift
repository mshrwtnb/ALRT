//
//  AppDelegate.swift
//  Demo
//
//  Created by Masahiro Watanabe on 7/30/16.
//  Copyright © 2016 Masahiro Watanabe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: DemoViewController())
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

