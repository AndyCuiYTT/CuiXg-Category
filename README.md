### UILabel
##### 设置字体和颜色
```swift
    /// 设置 Label 属性
    /// - Parameters:
    ///   - text: 文本内容
    ///   - font: 字体
    ///   - color: 字体颜色
    public func cxg_setAttribute(_ text: String? = nil, font: UIFont, textColor color: UIColor) {
    }
```
##### 加载 HTML
```swift
    /// 加载 HTML 标签
    /// - Parameter htmlStr: HTML 标签
    public func cxg_load(withHTML htmlStr: String?) {
    }
```
##### 设置价格样式 eg: ¥365.00
```swift
    /// 设置价格样式 eg: ¥365.00
    /// - Parameters:
    ///   - price: 价格
    ///   - textColor: 字体颜色
    ///   - prefixFont: ¥ 字体
    ///   - font: 价格字体
    public func cxg_setPriceAttribute(_ price: Double, format: String = "%.2f", textColor: UIColor, prefixFont: UIFont, font: UIFont) {
    }
```
### UIImage
##### 根据颜色生成图片
```swift
    /// 根据颜色生成图片
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片大小
    convenience public init(color: UIColor, size: CGSize) {
    }
```
##### 通过 URL 加载图片
```swift
    /// 通过 URL 加载图片
    ///
    /// - Parameter urlStr: 图片 URL 地址
    public class func cxg_init(withURL url: String) -> UIImage? {
    }
```
##### 截取视图生成图片
```swift
    /// 截取视图
    ///
    /// - Parameters:
    ///   - view: 要截取的视图
    /// - Returns: 要截取视图对应的 UIImage 对象
    public class func cxg_init(withView view: UIView) -> UIImage? {
    }
```
##### 获取圆形图片
```swift
    /// 获取圆形图片
    ///
    /// - Returns: 圆形图片
    public func cxg_circle() -> UIImage? {
    }
```
##### 获取圆角图片
```swift
    /// 获取圆角图片
    /// - Parameter radius: 圆角半径    
    public func cxg_cornerRadius(_ radius: CGFloat) -> UIImage? {
    }
```
##### 修改图片 size
```swift
    /// 修改图片 size
    ///
    /// - Parameter size: 图片大小
    /// - Returns: 修改后的图片
    public func cxg_reset(withSize size: CGSize) -> UIImage? {
    }
```
##### 修改图片 size alpha
```swift
    /// 修改图片 size alpha
    ///
    /// - Parameters:
    ///   - size: 图片大小
    ///   - alpha: 图片透明度
    /// - Returns: 修改后的图片
    public func cxg_reset(withSize size: CGSize, alpha: CGFloat) -> UIImage? {
    }
```
##### 根据宽度重新绘制图片
```swift
    /// 根据宽度重新绘制图片
    ///
    /// - Parameter width: 所需宽度
    /// - Returns: 所需尺寸图片
    public func cxg_reset(withWidth width: CGFloat) -> UIImage? {
    }
```
##### 根据高度重新绘制图片
```swift
    /// 根据高度重新绘制图片
    ///
    /// - Parameter height: 所需高度
    /// - Returns: 所需尺寸图片
    public func cxg_reset(withHeight height: CGFloat) -> UIImage? {
    }
```
##### 根据比例重新绘制图片
```swift
    /// 根据比例重新绘制图片
    ///
    /// - Parameter scale: 所需比例
    /// - Returns: 所需尺寸图片
    public func cxg_reset(withScale scale: CGFloat) -> UIImage? {
    }
```
##### 为图片添加图片遮罩
```swift
    /// 为图片添加图片遮罩
    ///
    /// - Parameters:
    ///   - maskImage: 遮罩图片
    ///   - maskRect: 遮罩层位置,大小
    /// - Returns: 添加遮罩图片
    public func cxg_addMaskImage(_ image: UIImage, maskRect rect: CGRect) -> UIImage? {
    }
```
##### 图片转 base64
```swift
    /// 图片转 base64
    ///
    /// - Returns: 图片 base64值
    public func cxg_toBase64() -> String? {
    }
```
##### 获取灰色图片
```swift
    /// 获取灰色图片
    /// - Parameter size: 灰色区域
    /// - Returns: 带有灰色图片
    public func cxg_grayImage() -> UIImage? {
    }
```
##### 获取根据 Data 获取 GIF
```swift
    /// 获取根据 Data 获取 GIF
    /// - Parameter data: GIF 动画 Data
    /// - Returns: GIF 图片
    public class func cxg_gif(data: Data) -> UIImage? {
    }
```
##### 获取根据 URL 获取 GIF
```swift
    /// 获取根据 URL 获取 GIF
    /// - Parameter url: GIF URL 地址
    /// - Returns: GIF 图片
    public class func cxg_gif(url: String) -> UIImage? {
    }
```
##### 根据 Path 获取 GIF
```swift
    /// 根据 Path 获取 GIF
    /// - Parameter url: GIF 路径
    /// - Returns: GIF 图片
    public class func cxg_gif(pathURL url: String) -> UIImage? {
    }
```
##### 根据 Name 获取 GIF
```swift
    /// 根据 Name 获取 GIF
    /// - Parameter url: GIF 路径
    /// - Returns: GIF 图片
    public class func cxg_gif(name: String) -> UIImage? {
    }
```
### UIImageView
##### UIImageView 设置 Image
```swift
    /// UIImageView 设置 Image
    ///
    /// - Parameters:
    ///   - URLStr: 图片 URL 地址
    ///   - imageNamed: 占位图名称
    public func cxg_setImage(_ URLStr: String?, placeholder imageNamed: String) {
    }
```
##### 加载图片,不走缓存
```swift
    /// 加载图片,不走缓存
    /// - Parameters:
    ///   - URLStr: 图片地址
    ///   - imageNamed: 占位图名
    ///   - completion: 下载完回调
    public func cxg_loadImage(_ URLStr: String?, placeholder imageNamed: String, completion: @escaping (UIImage?) -> Void) {
    }
```
##### 加载图片, 走缓存
```swift
    /// 加载图片, 走缓存
    /// - Parameters:
    ///   - URLStr: 图片地址
    ///   - imageNamed: 占位图名
    ///   - completion: 下载完回调
    public func cxg_setImage(_ URLStr: String?, placeholder imageNamed: String, completion: @escaping (UIImage?) -> Void) {
    }
```
##### 设置圆角
```swift
public var cxg_cornerRadius: CGFloat
```
##### 根据 GIF 名加载动态图
```swift
    /// 根据 GIF 名加载
    /// - Parameter name: GIF 文件名
    public func cxg_loadGif(name: String) {
    }
```
##### 根据 GIF URL加载动态图
```swift
    /// 根据 GIF URL加载
    /// - Parameter name: GIF 文件名
    public func cxg_loadGif(url: String) {
    }
```
##### 根据 GIF Path 路径加载动态图
```swift
    /// 根据 GIF Path 路径加载
    /// - Parameter name: GIF 文件名
    public func cxg_loadGif(pathURL url: String) {
    }
```
### UITextField
##### 设置字体，颜色
```swift
    /// 初始化 UITextField
    /// - Parameters:
    ///   - placeholder: 占位字符串
    ///   - font: 字体
    ///   - color: 颜色
    public func cxg_setAttribute(_ placeholder: String, font: UIFont, textColor color: UIColor) {
    }
```
### Date
##### 当前时间格式化
```swift
    /// 当前时间格式化
    ///
    /// - Parameter dateFormat: 时间格式
    /// - Returns: 格式化后时间
    public func cxg_formatterDate(_ dateFormat: String = "yyyy-MM-dd") -> String {
    }
```
### String
##### 生成 MD5
```swift
    /// 生成 MD5
    public func cxg_MD5() -> String {
    }
```
##### 时间转 Date
```swift
    public func cxg_date(_ dateFormat: String = "yyyy-MM-dd") -> Date? {
    }
```
##### 获取文字的 size
```swift
    /// 获取文字的 size
    /// - Parameters:
    ///   - font: 字号
    ///   - width: 宽
    ///   - height: 高
    public func cxg_size(_ font: UIFont, maxWidth width: CGFloat = CGFloat.greatestFiniteMagnitude, maxHeight height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
    }
```
##### 根据富文本获取文字的 size
```swift
    public func cxg_size(_ attributes: [NSAttributedString.Key : Any], maxWidth width: CGFloat = CGFloat.greatestFiniteMagnitude, maxHeight height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
    }
```
### UIColor
##### 利用 RGB 进行设置颜色
```swift
    /// 利用 RGB 进行设置颜色
    ///
    /// - Parameters:
    ///   - R: 色值
    ///   - G: 色值
    ///   - B: 色值
    ///   - alpha: 透明度
    /// - Returns: RGB 对应颜色
    convenience public init(R: CGFloat, G: CGFloat, B: CGFloat, alpha: CGFloat = 1) {
    }
```
##### 设置16进制色值
```swift
    /// 设置16进制色值
    ///
    /// - Parameters:
    ///   - hex: 16进制色值 例如:0xFFFFFF
    ///   - alpha: 透明度
    /// - Returns: 色值对应颜色
    convenience public init(hex: NSInteger, alpha: CGFloat = 1) {
    }
```
### NSObject
### UIView
...
