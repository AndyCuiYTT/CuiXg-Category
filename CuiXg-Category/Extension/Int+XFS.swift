//
//  Int+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2020/6/17.
//  Copyright © 2020 CuiXg. All rights reserved.
//

import UIKit

extension Int {

    /// Int  转 分秒
    /// - Returns: 转换后时间 00:00 格式
    func cxg_toMinutesSeconds(formatter: String = "%02d:%02d") -> String {
        guard self > 0 else {
            return "00:00"
        }
        return String(format: formatter, self / 60, self % 60)
    }

    func cxg_bToMb() -> String {
        guard self > 0 else {
            return "0M"
        }
        return String(format: "%.1fM", Double(self) / 1048576)
    }

    func cxg_bToGb() -> String {
        guard self > 0 else {
            return "0G"
        }
        return String(format: "%.1fG", Double(self) / 1073741824)
    }
}

extension Int32 {
    /// Int  转 分秒
    /// - Returns: 转换后时间 00:00 格式
    func cxg_toMinutesSeconds(formatter: String = "%02d:%02d") -> String {
        guard self > 0 else {
            return "00:00"
        }
        return String(format: formatter, self / 60, self % 60)
    }

    /// KB 转换 MB
    /// - Returns: 文件多少 M eg：10.5M
    func cxg_bToMb() -> String {
        guard self > 0 else {
            return "0M"
        }
        return String(format: "%.1fM", Double(self) / 1048576)
    }

    func cxg_bToGb() -> String {
        guard self > 0 else {
            return "0G"
        }
        return String(format: "%.1fG", Double(self) / 1073741824)
    }
}

extension Int64 {

    /// 毫秒  转 分秒
    /// - Returns: 转换后时间 00:00 格式
    func cxg_toMinutesSeconds(formatter: String = "%02d:%02d") -> String {
        guard self > 0 else {
            return "00:00"
        }
        let second = self / 1000
        return String(format: formatter, second / 60, second % 60)
    }
}
