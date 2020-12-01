//
//  UITextField+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2019/2/28.
//  Copyright © 2019 CuiXg. All rights reserved.
//

import UIKit

extension UITextField {

    /// 初始化 UITextField
    /// - Parameters:
    ///   - placeholder: 占位字符串
    ///   - font: 字体
    ///   - color: 颜色
    public func cxg_setAttribute(_ placeholder: String, font: UIFont, textColor color: UIColor) {
        self.placeholder = placeholder
        self.textColor = color
        self.font = font
    }
}
