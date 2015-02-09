//  Copyright (c) 2015 Fabián Cañas. All rights reserved.

import UIKit

class Box<T> {
    let unbox :T
    init(_ unbox: T) { self.unbox = unbox }
}

enum UIKNode {
    case View(_: UIView)
    case Controller(_: UIViewController)
}

protocol Dot {
    var subdots :[Dot] { get }
    func generate() -> UIKNode
}

struct View : Dot {
    var subdots :[Dot] = []
    func generate() -> UIKNode {
        let view = UIView()
        for node in subdots.map( { $0.generate() } ) {
            switch node {
            case let UIKNode.View(v):
                view.addSubview(v)
            case UIKNode.Controller(_):
                break
            }
        }
        return UIKNode.View(view)
    }
}

struct Label : Dot {
    let subdots :[Dot] = []
    var text :String
    init(text: String) {
        self.text = text
    }
    func generate() -> UIKNode {
        let label = UILabel()
        label.text = text
        label.sizeToFit()
        return UIKNode.View(label)
    }
}

struct Shim : Dot {
    var subdots :[Dot]
    var title: String = "Shim"
    func generate() -> UIKNode {
        let vc = UIViewController()
        vc.title = title
        vc.view.backgroundColor = UIColor.whiteColor()
        for node in subdots.map( { $0.generate() } ) {
            switch node {
            case let UIKNode.View(v):
                vc.view.addSubview(v)
            case UIKNode.Controller(_):
                break
            }
        }
        return UIKNode.Controller(vc)
    }
}

class Tab : Dot {
    var subdots :[Dot] = []
    func generate() -> UIKNode {
        let tab = UITabBarController()
        for node in subdots.map( { $0.generate() } ) {
            switch node {
            case UIKNode.View(_):
                break
            case let UIKNode.Controller(c):
                tab.addChildViewController(c)
            }
        }
        return UIKNode.Controller(tab)
    }
}

class Navigator : Dot {
    var subdots :[Dot] = []
    var title = "Nav"
    func generate() -> UIKNode {
        let nav = UINavigationController()
        nav.title = title
        for node in subdots.map( { $0.generate() } ) {
            switch node {
            case UIKNode.View(_):
                break
            case let UIKNode.Controller(c):
                nav.pushViewController(c, animated: false)
            }
        }
        return UIKNode.Controller(nav)
    }
}