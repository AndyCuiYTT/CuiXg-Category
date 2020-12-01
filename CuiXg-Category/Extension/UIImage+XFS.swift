//
//  CuiXg-Category
//
//  Created by CuiXg on 2019/2/28.
//  Copyright © 2019 CuiXg. All rights reserved.
//

// swiftlint:disable file_length

import UIKit

extension UIImage {

    /// 根据颜色生成图片
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片大小
    convenience public init(color: UIColor, size: CGSize) {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: size)
            if let newImage = renderer.image(actions: { (context) in
                let context = context.cgContext
                context.setFillColor(color.cgColor)
                context.fill(CGRect(origin: CGPoint(x: 0, y: 0), size: size))
            }).cgImage {
                self.init(cgImage: newImage)
            }else {
                self.init()
            }
        } else {
            let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            let context = UIGraphicsGetCurrentContext()
            context?.setFillColor(color.cgColor)
            context?.fill(rect)
            if let newImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage {
                self.init(cgImage: newImage)
            }else {
                self.init()
            }
            UIGraphicsEndImageContext()
        }
    }

    /// 通过 URL 加载图片
    ///
    /// - Parameter urlStr: 图片 URL 地址
    public class func cxg_init(withURL url: String) -> UIImage? {
        if let url = URL(string: url) {
            do {
                let imageData = try Data(contentsOf: url, options: .mappedIfSafe)
                return UIImage(data: imageData)
            }catch {}
        }
        return nil
    }

    /// 截取视图
    ///
    /// - Parameters:
    ///   - view: 要截取的视图
    /// - Returns: 要截取视图对应的 UIImage 对象
    public class func cxg_init(withView view: UIView) -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
            return renderer.image { (context) in
                view.layer.render(in: context.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    }

    /// 获取圆形图片
    ///
    /// - Returns: 圆形图片
    public func cxg_circle() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { (context) in
                let context = context.cgContext
                context.addEllipse(in: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
                context.clip()
                self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
            let context = UIGraphicsGetCurrentContext()
            context?.addEllipse(in: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
            context?.clip()
            self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
    }

    /// 获取圆角图片
    /// - Parameter radius: 圆角半径
    public func cxg_cornerRadius(_ radius: CGFloat) -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { (context) in
                let context = context.cgContext
                context.addPath(UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size), cornerRadius: radius).cgPath)
                context.clip()
                self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
            let context = UIGraphicsGetCurrentContext()
            context?.addPath(UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size), cornerRadius: radius).cgPath)
            context?.clip()
            self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
    }

    /// 修改图片 size
    ///
    /// - Parameter size: 图片大小
    /// - Returns: 修改后的图片
    public func cxg_reset(withSize size: CGSize) -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { (_) in
                self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
    }

    /// 修改图片 size alpha
    ///
    /// - Parameters:
    ///   - size: 图片大小
    ///   - alpha: 图片透明度
    /// - Returns: 修改后的图片
    public func cxg_reset(withSize size: CGSize, alpha: CGFloat) -> UIImage? {

        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { (_) in
                self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: CGBlendMode.normal, alpha: alpha)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: CGBlendMode.normal, alpha: alpha)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
    }

    /// 根据宽度重新绘制图片
    ///
    /// - Parameter width: 所需宽度
    /// - Returns: 所需尺寸图片
    public func cxg_reset(withWidth width: CGFloat) -> UIImage? {
        let height = self.size.height * (width / self.size.width)
        return cxg_reset(withSize: CGSize(width: width, height: height))
    }

    /// 根据高度重新绘制图片
    ///
    /// - Parameter height: 所需高度
    /// - Returns: 所需尺寸图片
    public func cxg_reset(withHeight height: CGFloat) -> UIImage? {
        let width = self.size.width * (height / self.size.height)
        return cxg_reset(withSize: CGSize(width: width, height: height))
    }

    /// 根据比例重新绘制图片
    ///
    /// - Parameter scale: 所需比例
    /// - Returns: 所需尺寸图片
    public func cxg_reset(withScale scale: CGFloat) -> UIImage? {
        return cxg_reset(withSize: CGSize(width: self.size.width * scale, height: self.size.height * scale))
    }

    /// 为图片添加图片遮罩
    ///
    /// - Parameters:
    ///   - maskImage: 遮罩图片
    ///   - maskRect: 遮罩层位置,大小
    /// - Returns: 添加遮罩图片
    public func cxg_addMaskImage(_ image: UIImage, maskRect rect: CGRect) -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { (_) in
                self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                image.draw(in: rect)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
            self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
    }

    /// 图片转 base64
    ///
    /// - Returns: 图片 base64值
    public func cxg_toBase64() -> String? {
        let imageData = self.pngData()
        return imageData?.base64EncodedString(options: .lineLength64Characters)
    }

    /// 获取灰色图片
    /// - Parameter size: 灰色区域
    /// - Returns: 带有灰色图片
    public func cxg_grayImage() -> UIImage? {
        guard let cgImage = self.cgImage else {
            return nil
        }
        // 获取原图像的尺寸属性
        let originalImageSize = self.size
        // 获取原图像的宽度
        let originalImageWidth = Int(originalImageSize.width)
        // 获取原图像的高度
        let originalImageHidth = Int(originalImageSize.height)

        // 创建灰度色彩空间的对象，各种设备对待颜色的方式都不同，颜色必须有一个相关的色彩空间，否则图像上下文将不知道如何解释相关的颜色值
        let colorSpace = CGColorSpaceCreateDeviceGray()
        // 参数1：指向要渲染的绘制内存的地址，参数2，3：高度和宽度，参数4：表示内存中像素的每个组件的位数，参数5：每一行在内存所占的比特数
        // 参数6：表示上下文使用的颜色空间，参数7：表示是否包含透明通道
        guard let context = CGContext(data: nil, width: originalImageWidth, height: originalImageHidth, bitsPerComponent: 16, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue) else {
            return nil
        }
        context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: CGSize(width: originalImageWidth, height: originalImageHidth)))
        guard let newCGImage = context.makeImage() else {
            return nil
        }
        return UIImage(cgImage: newCGImage)
    }

}

// MARK: gif 加载
extension UIImage {

    /// 获取根据 Data 获取 GIF
    /// - Parameter data: GIF 动画 Data
    /// - Returns: GIF 图片
    public class func cxg_gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            assertionFailure("SwiftGif: Source for the image does not exist")
            return nil
        }

        return UIImage.animatedImageWithSource(source)
    }

    /// 获取根据 URL 获取 GIF
    /// - Parameter url: GIF URL 地址
    /// - Returns: GIF 图片
    public class func cxg_gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            assertionFailure("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            assertionFailure("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }

        return cxg_gif(data: imageData)
    }

    /// 根据 Path 获取 GIF
    /// - Parameter url: GIF 路径
    /// - Returns: GIF 图片
    public class func cxg_gif(pathURL url: String) -> UIImage? {

        // Validate data
        guard let imageData = try? Data(contentsOf: URL(fileURLWithPath: url)) else {
            assertionFailure("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }

        return cxg_gif(data: imageData)
    }

    /// 根据 Name 获取 GIF
    /// - Parameter url: GIF 路径
    /// - Returns: GIF 图片
    public class func cxg_gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            assertionFailure("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            assertionFailure("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return cxg_gif(data: imageData)
    }

    @available(iOS 9.0, *)
    public class func cxg_gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            assertionFailure("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }

        return cxg_gif(data: dataAsset.data)
    }

    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1

        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
            return delay
        }

        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)

        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            delay = 0.1 // Make sure they're not too fast
        }

        return delay
    }

    internal class func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
        var lhs = lhs
        var rhs = rhs
        // Check if one of them is nil
        if rhs == nil || lhs == nil {
            if rhs != nil {
                return rhs!
            } else if lhs != nil {
                return lhs!
            } else {
                return 0
            }
        }

        // Swap for modulo
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }

        // Get greatest common divisor
        var rest: Int
        while true {
            rest = lhs! % rhs!

            if rest == 0 {
                return rhs! // Found it
            } else {
                lhs = rhs
                rhs = rest
            }
        }
    }

    internal class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }

        var gcd = array[0]

        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }

        return gcd
    }

    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()

        // Fill arrays
        for index in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }

            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }

        // Calculate full duration
        let duration: Int = {
            var sum = 0

            for val: Int in delays {
                sum += val
            }

            return sum
        }()

        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()

        var frame: UIImage
        var frameCount: Int
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcd)

            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }

        // Heyhey
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)

        return animation
    }

}

// MARK: 二维码生成
extension UIImage {

    /// 生成二维码
    /// - Parameters:
    ///   - contentInfo: 我二维码内容
    ///   - size: 二维码大小
    ///   - backgroudColor: 二维码背景色
    ///   - foregroundColor: 二维码颜色
    class func cxg_QRCode(contentInfo: String, size: CGSize, backgroudColor: UIColor = UIColor.white, foregroundColor: UIColor = UIColor.black) -> UIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }

        filter.setDefaults()
        // 容错率
        filter.setValue("L", forKey: "inputCorrectionLevel")
        filter.setValue(contentInfo.data(using: .utf8), forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }

        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValue(ciImage, forKey: "inputImage")
        // 前景色
        colorFilter?.setValue(CIColor(color: foregroundColor), forKey: "inputColor0")
        // 背景色
        colorFilter?.setValue(CIColor(color: backgroudColor), forKey: "inputColor1")

        let scale = min(size.width / ciImage.extent.width, size.height / ciImage.extent.height)
        if #available(iOS 10.0, *) {
            if let transFormImage = colorFilter?.outputImage?.transformed(by: CGAffineTransform(scaleX: scale, y: scale), highQualityDownsample: true) {
                return UIImage(ciImage: transFormImage)
            }else {
                return UIImage(ciImage: ciImage)
            }

        } else {
            if let transFormImage = colorFilter?.outputImage?.transformed(by: CGAffineTransform(scaleX: scale, y: scale)) {
                return UIImage(ciImage: transFormImage)
            }else {
                return UIImage(ciImage: ciImage)
            }
        }
    }
}

extension UIImage {

    public enum CXGGradientType {
        case topToBottom
        case leftToRight
        case topLeftToBottomRight
        case topRightToBottomLeft
    }

    /// 生成渐变色图片
    /// - Parameters:
    ///   - colors: 开始颜色，终止颜色，以及过度色
    ///   - type: 渐变方向
    ///   - locations: 每个颜色在渐变色中的位置，值介于0.0-1.0之间
    ///   - size: 图片大小
    convenience public init(colors: [UIColor], gradientType type: CXGGradientType, locations: [CGFloat], size: CGSize) {
        assert(colors.count == locations.count, "渐变数组与颜色位置数组 count 不一致")
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let cgColors = colors.compactMap { (color) -> CGColor in
            return color.cgColor
        }

        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
            self.init()
            return
        }
        switch type {
        case .leftToRight:
            context?.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size.width, y: 0), options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        case .topToBottom:
            context?.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        case .topLeftToBottomRight:
            context?.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size.width, y: size.height), options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        case .topRightToBottomLeft:
            context?.drawLinearGradient(gradient, start: CGPoint(x: size.width, y: 0), end: CGPoint(x: 0, y: size.height), options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        }
        if let newImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage {
            self.init(cgImage: newImage)
        }else {
            self.init()
        }
        context?.restoreGState()
        UIGraphicsEndImageContext()
    }
}
