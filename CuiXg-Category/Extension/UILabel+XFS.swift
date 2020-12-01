//
//  UILabel+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2019/2/28.
//  Copyright © 2019 CuiXg. All rights reserved.
//

import UIKit

extension UILabel {

    /// 设置 Label 属性
    /// - Parameters:
    ///   - text: 文本内容
    ///   - font: 字体
    ///   - color: 字体颜色
    public func cxg_setAttribute(_ text: String? = nil, font: UIFont, textColor color: UIColor) {
        if text != nil {
            self.text = text
        }
        self.font = font
        self.textColor = color
    }

    /// 加载 HTML 标签
    /// - Parameter htmlStr: HTML 标签
    public func cxg_load(withHTML htmlStr: String?) {
        if let data = htmlStr?.data(using: String.Encoding.unicode), let attributedStr = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            attributedStr.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSRange(location: 0, length: attributedStr.length))
            self.attributedText = attributedStr
        }
    }

    /// 设置价格样式 eg: ¥365.00
    /// - Parameters:
    ///   - price: 价格
    ///   - textColor: 字体颜色
    ///   - prefixFont: ¥ 字体
    ///   - font: 价格字体
    public func cxg_setPriceAttribute(_ price: Double, format: String = "%.2f", textColor: UIColor, prefixFont: UIFont, font: UIFont) {
        let priceAttributedStr = NSMutableAttributedString(string: String(format: "¥\(format)", price), attributes: [.font: font, .foregroundColor: textColor])
        priceAttributedStr.addAttributes([.font: prefixFont, .foregroundColor: textColor], range: NSRange(location: 0, length: 1))
        self.attributedText = priceAttributedStr
    }
}
