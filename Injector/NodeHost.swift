//  Copyright (c) 2015 Fabián Cañas. All rights reserved.

import UIKit

class NodeHost: UIViewController {
    var node: xNode? {
        didSet {
            title = "Hosting"
            
            for v in self.view.subviews {
                v.removeFromSuperview()
            }
            if let n = node {
                let newView = viewForNode(n)
                view.addSubview(newView)
            }
        }
    }
}

enum xNode {
    case Label(text: String, backgroundColor: UIColor, textColor: UIColor)
    case View(nodes: [xNode], backgroundColor: UIColor)
}

func viewForNode(node: xNode) -> UIView {
    switch node {
    case let xNode.Label(text, backgroundColor, textColor):
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.sizeToFit()
        return label
    case let xNode.View(nodes, backgroundColor) :
        let view = UIView()
        view.backgroundColor = backgroundColor
        for v in nodes.map((viewForNode)) { view.addSubview(v) }
        view.sizeToFit()
        return view
    }
}