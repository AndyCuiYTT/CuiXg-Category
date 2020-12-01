//
//  CuiXg-Category
//
//  Created by CuiXg on 2019/3/1.
//  Copyright © 2019 CuiXg. All rights reserved.
//

import UIKit

let kScreenScale = UIScreen.main.bounds.width

public protocol CXGLayoutAdaptionDelegate {
    var cxg_cgFloat: CGFloat { get }
}

extension CXGLayoutAdaptionDelegate {

    /// 根据屏幕自适应
    internal var cxg_adaption: CGFloat {
        return cxg_cgFloat * kScreenScale
    }
}

extension CGFloat: CXGLayoutAdaptionDelegate {

    public var cxg_cgFloat: CGFloat {
        return self
    }
}

extension Int: CXGLayoutAdaptionDelegate {

    public var cxg_cgFloat: CGFloat {
        return CGFloat(self)
    }
}

extension UInt: CXGLayoutAdaptionDelegate {

    public var cxg_cgFloat: CGFloat {
        return CGFloat(self)
    }
}

extension Float: CXGLayoutAdaptionDelegate {

    public var cxg_cgFloat: CGFloat {
        return CGFloat(self)
    }
}

extension Double: CXGLayoutAdaptionDelegate {

    public var cxg_cgFloat: CGFloat {
        return CGFloat(self)
    }
}
