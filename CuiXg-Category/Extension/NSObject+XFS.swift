//
//  NSObject+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2019/11/20.
//  Copyright © 2019 CuiXg. All rights reserved.
//

import UIKit

extension NSObject {

    /// 获取当前对象对应文件名
    func cxg_className() -> String {
        let name = type(of: self).description()
        if let temp = name.components(separatedBy: ".").last {
            return temp
        }else {
            return name
        }
    }

}
