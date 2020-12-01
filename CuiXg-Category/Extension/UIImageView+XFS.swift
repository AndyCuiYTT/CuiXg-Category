//
//  CuiXg-Category
//
//  Created by CuiXg on 2019/6/4.
//  Copyright © 2019 CuiXg. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {

     private var webImageManager: SDWebImageManager {
        return SDWebImageManager.shared
    }

    /// UIImageView 设置 Image
    ///
    /// - Parameters:
    ///   - URLStr: 图片 URL 地址
    ///   - imageNamed: 占位图名称
    public func cxg_setImage(_ URLStr: String?, placeholder imageNamed: String) {
        if let str = URLStr, let url = URL(string: str) {
            self.sd_setImage(with: url, placeholderImage: UIImage(named: imageNamed))
        }else {
            self.image = UIImage(named: imageNamed)
        }
    }

    public func cxg_setImage(_ URLStr: String?, placeholderImage image: UIImage?) {
        if let str = URLStr, let url = URL(string: str) {
            self.sd_setImage(with: url, placeholderImage: image)
        }else {
            self.image = image
        }
    }


    /// 加载图片,不走缓存
    /// - Parameters:
    ///   - URLStr: 图片地址
    ///   - imageNamed: 占位图名
    ///   - completion: 下载完回调
    public func cxg_loadImage(_ URLStr: String?, placeholder imageNamed: String, completion: @escaping (UIImage?) -> Void) {
        self.image = UIImage(named: imageNamed)
        if let str = URLStr, let url = URL(string: str) {
            self.webImageManager.loadImage(with: url, options: .highPriority, progress: nil) { (image, _, _, _, _, _) in
                self.image = image
                completion(image)
            }
        }
    }

    /// 加载图片, 走缓存
    /// - Parameters:
    ///   - URLStr: 图片地址
    ///   - imageNamed: 占位图名
    ///   - completion: 下载完回调
    public func cxg_setImage(_ URLStr: String?, placeholder imageNamed: String, completion: @escaping (UIImage?) -> Void) {
        if let str = URLStr, let url = URL(string: str) {
            self.sd_setImage(with: url, placeholderImage: UIImage(named: imageNamed), options: .highPriority) { (image, _, _, _) in
                completion(image)
            }
        }
    }


    /// 圆角大小
    @IBInspectable override public var cxg_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

}

extension UIImageView {

    /// 根据 GIF 名加载
    /// - Parameter name: GIF 文件名
    public func cxg_loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.cxg_gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

    /// 根据 GIF URL加载
    /// - Parameter name: GIF 文件名
    public func cxg_loadGif(url: String) {
        DispatchQueue.global().async {
            let image = UIImage.cxg_gif(url: url)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

    /// 根据 GIF Path 路径加载
    /// - Parameter name: GIF 文件名
    public func cxg_loadGif(pathURL url: String) {
        DispatchQueue.global().async {
            let image = UIImage.cxg_gif(pathURL: url)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

    @available(iOS 9.0, *)
    public func cxg_loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.cxg_gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
