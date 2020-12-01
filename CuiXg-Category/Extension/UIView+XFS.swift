//
//  UIView+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2019/3/4.
//  Copyright © 2019 CuiXg. All rights reserved.
//
// swiftlint:disable identifier_name

import UIKit

extension UIView {

    /// 设置圆角
    ///
    /// - Parameters:
    ///   - ornerRadius: 圆角弧度
    ///   - corners: 设置圆角位置
    func cxg_setRoundingCorners(_ cornerRadius: CGFloat, roundingCorners corners: UIRectCorner = .allCorners, size: CGSize = .zero) {

        if corners == .allCorners {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = cornerRadius
            return
        }

        let maskPath = UIBezierPath(roundedRect: size == .zero ? self.bounds : CGRect(origin: CGPoint.zero, size: size), byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame =  size == .zero ? self.bounds : CGRect(origin: CGPoint.zero, size: size)
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }

    /// 添加阴影
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - offset: 偏移
    ///   - opacity: 透明度
    ///   - radius: 阴影半径
    func cxg_shadow(color: UIColor = QWColor.shadow, offset: CGSize = CGSize(width: 3, height: 3), opacity: Float = 0.8, radius: CGFloat = 4) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }

    /// 圆角大小
    @IBInspectable var cxg_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    /// 边框宽度
    @IBInspectable var cxg_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }

    /// 边框颜色
    @IBInspectable var cxg_borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
