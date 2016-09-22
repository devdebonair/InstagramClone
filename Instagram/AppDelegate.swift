//
//  AppDelegate.swift
//  Instagram
//
//  Created by Vincent Moore on 5/28/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .default
        
        UINavigationBar.appearance().barTintColor = COLOR_BACKGROUND
        UINavigationBar.appearance().tintColor = COLOR_TINT
        UINavigationBar.appearance().isTranslucent = false
        
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.frame.origin.y = tabBarController.tabBar.frame.origin.y + 6
        tabBarController.tabBar.barTintColor = COLOR_BACKGROUND.withAlphaComponent(0.25)
        tabBarController.tabBar.tintColor = COLOR_TINT
        
        let feedController = HomeTableViewController()
        let searchController = SearchCollectionViewController()
        let navigationSearch = UINavigationController(rootViewController: searchController)
        let navigationController = UINavigationController(rootViewController: feedController)
        
        feedController.tabBarItem.image = UIImage(named: "home")
        feedController.tabBarItem.selectedImage = UIImage(named: "home-filled")
        feedController.view.backgroundColor = COLOR_BACKGROUND
        
        searchController.tabBarItem.image = UIImage(named: "search")
        searchController.tabBarItem.selectedImage = UIImage(named: "search-filled")
        searchController.view.backgroundColor = COLOR_BACKGROUND
        
        tabBarController.viewControllers = [navigationController, navigationSearch]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        window?.backgroundColor = UIColor.white
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

