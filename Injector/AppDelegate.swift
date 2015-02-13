//  Copyright (c) 2015 Fabián Cañas. All rights reserved.

import UIKit
import JavaScriptCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let app = loadProgram("app") ?? ""
        
        let context = JSContext(virtualMachine: JSVirtualMachine())
        context.evaluateScript(app)
        let originAppTree = context.objectForKeyedSubscript("appTree").toDictionary()
        
        let rawTree = RawNode()
        rawTree.setValuesForKeysWithDictionary(originAppTree)
        
        let tab = rawTree.toNode()
        
        // Host
        let hostVC = NodeHost()
        let node = xNode.View(nodes: [
            xNode.Label(text: "there!", backgroundColor: UIColor.clearColor(), textColor: UIColor.greenColor()),
            xNode.Label(text: "Hi", backgroundColor: UIColor.lightGrayColor(), textColor: UIColor.magentaColor())],
            backgroundColor: UIColor.darkGrayColor())
        hostVC.node = node
        
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
    
    func loadProgram(name: String) -> String? {
        if let path = NSBundle.mainBundle().pathForResource(name, ofType: "js") {
            if let program = NSString(contentsOfFile: path, usedEncoding: nil, error: nil) as? String {
                return program
            }
        }
        return nil
    }
}

