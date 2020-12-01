//
//  CXGLayoutAdaptionDelegate.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2019/3/1.
//  Copyright © 2019 CuiXg. All rights reserved.
//
// swiftlint:disable identifier_name
// swiftlint:disable class_delegate_protocol

import UIKit

protocol CXGLayoutAdaptionDelegate {
    var cxg_cgFloat: CGFloat { get }
}

extension CXGLayoutAdaptionDelegate {

    /// 根据屏幕自适应
    internal var cxg_adaption: CGFloat {
        return cxg_cgFloat * kScreenScale
    }
}

extension CGFloat: CXGLayoutAdaptionDelegate {

    var cxg_cgFloat: CGFloat {
        return self
    }
}

extension Int: CXGLayoutAdaptionDelegate {

    var cxg_cgFloat: CGFloat {
        return CGFloat(self)
    }
}

extension UInt: CXGLayoutAdaptionDelegate {

    var cxg_cgFloat: CGFloat {
        return CGFloat(self)
    }
}

extension Float: CXGLayoutAdaptionDelegate {

    var cxg_cgFloat: CGFloat {
        return CGFloat(self)
    }
}

extension Double: CXGLayoutAdaptionDelegate {

    var cxg_cgFloat: CGFloat {
        return CGFloat(self)
    }
}
