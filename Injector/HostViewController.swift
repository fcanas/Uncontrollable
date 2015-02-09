//  Copyright (c) 2015 Fabián Cañas. All rights reserved.

import UIKit

class HostViewController: UIViewController {
    
    var node: Node? {
        didSet {
            for v in self.view.subviews {
                v.removeFromSuperview()
            }
            if let n = node {
                let newView = viewForNode(n)
                view.addSubview(newView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node = Node.View(nodes: [
            Node.Label(text: "Hi", backgroundColor: UIColor.lightGrayColor(), textColor: UIColor.magentaColor()),
            Node.Label(text: "there!", backgroundColor: UIColor.darkGrayColor(), textColor: UIColor.greenColor())], backgroundColor: UIColor.darkGrayColor())
    }
}

enum Node {
    case Label(text: String, backgroundColor: UIColor, textColor: UIColor)
    case View(nodes: [Node], backgroundColor: UIColor)
}

func viewForNode(node: Node) -> UIView {
    switch node {
    case let Node.Label(text, backgroundColor, textColor):
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.sizeToFit()
        return label
    case let Node.View(nodes, backgroundColor) :
        let view = UIView()
        view.backgroundColor = backgroundColor
        for v in nodes.map((viewForNode)) {
            view.addSubview(v)
        }
        view.sizeToFit()
        return view
    }
}
