//
//  String+CXG.swift
//  CuiXg-Category
//
//  Created by CuiXg on 2019/8/23.
//  Copyright © 2019 CuiXg. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {

    /// 生成 MD5
    func cxg_MD5() -> String {
        let str = self.cString(using: .utf8)
        let strLength = CUnsignedInt(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: digestLen)
        CC_MD5(str!, strLength, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return (hash as String).uppercased()
    }

    func cxg_date(_ dateFormat: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }

    /// 获取文字的 size
    /// - Parameters:
    ///   - font: 字号
    ///   - width: 宽
    ///   - height: 高
    func cxg_size(_ font: UIFont, maxWidth width: CGFloat = CGFloat.greatestFiniteMagnitude, maxHeight height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return (self as NSString).boundingRect(with: CGSize(width: width, height: height), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil).size
    }

    func cxg_size(_ attributes: [NSAttributedString.Key : Any], maxWidth width: CGFloat = CGFloat.greatestFiniteMagnitude, maxHeight height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return (self as NSString).boundingRect(with: CGSize(width: width, height: height), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil).size
    }

    func cxg_int() -> Int {
        return Int(self) ?? 0
    }
}
