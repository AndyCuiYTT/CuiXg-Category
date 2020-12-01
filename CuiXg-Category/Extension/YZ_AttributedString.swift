//
//  YZ_AttributedString.swift
//  CuiXg-Category
//
//  Created by HYZ on 2020/9/25.
//  Copyright © 2020 CuiXg. All rights reserved.
//

import UIKit

extension NSObject {

    /**
     Convenience the init of attributedString

     param1 : string  the string with no attributesArr
     param2 : fontandrange  the array of font,range.location,range.length
     param3 : colorandRange  the array of color , range.location,range.length

     return NSAttributedString

     */
   class func  makeuserAttributedString(string:String,  fontandrange:[(font:UIFont,flocation:Int,flength:Int)], colorandRange:[(UIColor,clocation:Int,clength:Int)] ) -> NSAttributedString {
        let needStr = NSMutableAttributedString.init(string: string)

        for (font,flocation,flength) in fontandrange {
            if flocation + flength <= string.count {

                needStr.addAttributes([.font:font as Any], range: NSRange.init(location: flocation, length: flength))

            }
        }

        for (color,clocation,clength) in colorandRange {
            if clocation + clength <= string.count {
               needStr.addAttributes([.foregroundColor:color as Any], range: NSRange.init(location: clocation, length: clength))
            }
        }


        let needreStr = NSAttributedString.init(attributedString: needStr)

        return needreStr 

    }
}
