//
//  UIButton + EnlargeClick.swift
//  CuiXg-Category
//
//  Created by HYZ on 2020/9/25.
//  Copyright © 2020 CuiXg. All rights reserved.
//

import UIKit


private var key : Void?
extension UIButton {
    var enlargeEdgeInsets :UIEdgeInsets {
        get {
            return objc_getAssociatedObject(self, &key) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        }
    }

    func yz_setEnlargeEdge(size:CGFloat){
        self.enlargeEdgeInsets = UIEdgeInsets.init(top: size, left: size, bottom: size, right: size)
    }

    func yz_setEnlargeEdge(top:CGFloat,left:CGFloat,right:CGFloat,bottom:CGFloat) {
        self.enlargeEdgeInsets = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)

    }

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var rect = self.bounds
        if self.enlargeEdgeInsets != UIEdgeInsets.zero {
            let edge = self.enlargeEdgeInsets
            rect = CGRect.init(x: self.bounds.origin.x - edge.left, y: self.bounds.origin.y - edge.top
                               , width: self.bounds.size.width + edge.left + edge.right, height: self.bounds.size.height + edge.top + edge.bottom)

        }

        if rect == self.bounds {
            return super.point(inside: point, with: event)
        }

        return rect.contains(point) ? true : false
    }





}
