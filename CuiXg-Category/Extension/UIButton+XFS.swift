//
//  UIButton+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2019/6/25.
//  Copyright © 2019 CuiXg. All rights reserved.
//

import UIKit

extension UIButton {
    /// UIImageView 设置 Image
    ///
    /// - Parameters:
    ///   - URLStr: 图片 URL 地址
    ///   - imageNamed: 占位图名称
    public func cxg_setImage(_ URLStr: String, state: UIControl.State, placeholder imageNamed: String) {
        if let url = URL(string: URLStr) {
            self.sd_setBackgroundImage(with: url, for: state, placeholderImage: UIImage(named: imageNamed))
        }else {
            self.setImage(UIImage(named: imageNamed), for: state)
        }
    }

    /// Button 设置属性
    /// - Parameters:
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    ///   - font: 标题字体
    ///   - state: 状态
    public func cxg_setAttribute(title: String, titleColor: UIColor, font: UIFont, image: UIImage? = nil, for state: UIControl.State) {
        self.setTitle(title, for: state)
        self.setTitleColor(titleColor, for: state)
        if let img = image {
            self.setImage(img, for: state)
        }

        self.titleLabel?.font = font
    }

    @IBInspectable override public var cxg_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
