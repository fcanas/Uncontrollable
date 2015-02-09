//
//  AppDelegate.swift
//  Injector
//
//  Created by Fabian Canas on 2/8/15.
//  Copyright (c) 2015 Fabián Cañas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let hostVC = HostViewController()
        window?.rootViewController = hostVC
        
        let node = Node.View(nodes: [
            Node.Label(text: "there!", backgroundColor: UIColor.clearColor(), textColor: UIColor.greenColor()),
            Node.Label(text: "Hi", backgroundColor: UIColor.lightGrayColor(), textColor: UIColor.magentaColor())],
            backgroundColor: UIColor.darkGrayColor())
        
        hostVC.node = node
        
        window?.makeKeyAndVisible()
        return true
    }
}

