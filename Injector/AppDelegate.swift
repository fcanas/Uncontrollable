//  Copyright (c) 2015 Fabián Cañas. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Host
        let hostVC = NodeHost()
        let node = Node.View(nodes: [
            Node.Label(text: "there!", backgroundColor: UIColor.clearColor(), textColor: UIColor.greenColor()),
            Node.Label(text: "Hi", backgroundColor: UIColor.lightGrayColor(), textColor: UIColor.magentaColor())],
            backgroundColor: UIColor.darkGrayColor())
        hostVC.node = node
        
        // Dots
        let tab = Tab()
        let nav = Navigator()
        nav.subdots = [
            Label(text: "Root"),
            Label(text: "Middle"),
            Label(text: "Top")]
        nav.title = "Navigator"
        
        tab.subdots = [
            Label(text: "First"),
            Label(text: "Second"),
            nav
        ]
        var tabController :UITabBarController?
        switch tab.generate() {
        case let .Controller(t):
            t.addChildViewController(hostVC)
            window?.rootViewController = t
        case .View(_):
            window?.rootViewController = hostVC
        }
        
        window?.makeKeyAndVisible()
        return true
    }
}

