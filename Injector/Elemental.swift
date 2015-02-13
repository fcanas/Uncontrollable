//  Copyright (c) 2015 Fabián Cañas. All rights reserved.

import UIKit

public final class Box<T> {
    let unbox: T
    init(_ v: T) { unbox = v }
}

enum UIKNode {
    case View(_: UIView, title: String)
    case Controller(_: UIViewController)
}

enum NodeType {
    case View
    case Label
    case Tab
    case Navigator
}

protocol Node {
    var subnodes :[Node] { get set }
    func generate() -> UIKNode
}

struct View : Node {
    var subnodes :[Node] = []
    var title :String = ""
    func generate() -> UIKNode {
        let view = UIView()
        for node in subnodes.map( { $0.generate() } ) {
            switch node {
            case let UIKNode.View(v, _):
                view.addSubview(v)
            case UIKNode.Controller(_):
                break
            }
        }
        return UIKNode.View(view, title: title)
    }
}

struct Label : Node {
    var subnodes :[Node] = []
    var text :String
    init(text: String) {
        self.text = text
    }
    func generate() -> UIKNode {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFontOfSize(40)
        label.sizeToFit()
        label.backgroundColor = UIColor.whiteColor()
        return UIKNode.View(label, title: text)
    }
}

class Tab : Node {
    var subnodes :[Node] = []
    var title :String? = "Tab"
    func generate() -> UIKNode {
        let tab = UITabBarController()
        for node in subnodes.map( { $0.generate() } ) {
            switch node {
            case let UIKNode.View(v, title):
                let shim = controllerWithView(v, title)
                tab.addChildViewController(shim)
            case let UIKNode.Controller(c):
                tab.addChildViewController(c)
            }
        }
        return UIKNode.Controller(tab)
    }
}

func controllerWithView(view: UIView, title: String, backgroundColor: UIColor = UIColor.whiteColor()) -> UIViewController {
    let controller = UIViewController()
    controller.view.addSubview(view)
    controller.title = title
    controller.view.backgroundColor = backgroundColor
    return controller
}

class Navigator : Node {
    var subnodes :[Node] = []
    var title :String = "Nav"
    func generate() -> UIKNode {
        let nav = UINavigationController()
        nav.view.backgroundColor = UIColor.whiteColor()
        nav.title = title
        for node in subnodes.map( { $0.generate() } ) {
            switch node {
            case let UIKNode.View(v, title):
                let shim = controllerWithView(v, title)
                nav.pushViewController(shim, animated: false)
            case let UIKNode.Controller(c):
                nav.pushViewController(c, animated: false)
            }
        }
        return UIKNode.Controller(nav)
    }
}

extension RawNode {
    func toNode() -> Node {
        let typeMap: [String : NodeType] = [
            "Tab":.Tab,
            "Navigator":.Navigator,
            "Label":.Label,
            "View":.View
        ]
        var node :Node!
        
        switch typeMap[type]! {
        case .Tab:
            node = Tab()
        case .Navigator:
            node = Navigator()
        case .Label:
            node = Label(text: properties?["text"] as? String ?? "default")
        case .View:
            node = View()
        }
        
        if let sn = subnodes {
            node.subnodes = sn.map( {r in return (r as? RawNode)!.toNode() } )
        }
        
        return node
    }
}
