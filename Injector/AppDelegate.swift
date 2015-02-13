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
        
        switch tab.generate() {
        case let .Controller(t):
            window?.rootViewController = t
        case let .View(v, s):
            let c = UIViewController()
            c.view = v
            window?.rootViewController = c
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

