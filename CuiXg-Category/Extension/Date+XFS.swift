//
//  Date+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2019/11/14.
//  Copyright © 2019 CuiXg. All rights reserved.
//

import UIKit

extension Date {
    /// 当前时间格式化
    ///
    /// - Parameter dateFormat: 时间格式
    /// - Returns: 格式化后时间
    public func cxg_formatterDate(_ dateFormat: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }

    /// 获取 Date 对应组件值
    /// - Parameter component: 组件部位
    /// - Returns: 组件值
    public func cxg_getComponent(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }

    /// 获取时间年份
    public func cxg_getYear() -> Int {
        return cxg_getComponent(.year)
    }

    /// 获取月份
    public func cxg_getMonth() -> Int {
        return cxg_getComponent(.month)
    }

    /// 获取天
    public func cxg_getDay() -> Int {
        return cxg_getComponent(.day)
    }

    public func cxg_beginDay() -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components)
    }
}
