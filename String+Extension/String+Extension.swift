//
//  String+Extension.swift
//  iTour
//
//  Created by Super on 2017/10/18.
//  Copyright © 2017年 Croninfo. All rights reserved.
//

import Foundation
import UIKit
extension String {
    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    public func stringCut(end: Int) -> String {
        if !(end <= count) { return self }
        let sInde = index(startIndex, offsetBy: end)
        return String(self[..<sInde])
    }
    /// 截取任意位置到结束
    ///
    /// - Parameter end:
    /// - Returns: 截取后的字符串
    public func stringCutToEnd(star: Int) -> String {
        if !(star < count) { return "截取超出范围" }
        let sRang = index(startIndex, offsetBy: star)..<endIndex
        return String(self[sRang])
    }
    /// 截取最后几位
    ///
    /// - Parameter last:
    /// - Returns: 截取后的字符串
    public func stringCutLastEnd(last: Int) -> String {
        if !(last < count) { return "截取超出范围" }
        let sRang = index(endIndex, offsetBy: -last)..<endIndex
        return String(self[sRang])
    }
    /// 字符串任意位置插入
    ///
    /// - Parameters:
    ///   - content: 插入内容
    ///   - locat: 插入的位置
    /// - Returns: 添加后的字符串
    public func stringInsert(content: String,locat: Int) -> String {
        if !(locat < count) { return "操作超出范围" }
        let str1 = stringCut(end: locat)
        let str2 = stringCutToEnd(star: locat)
        return str1 + content + str2
    }
    /// 计算字符串的尺寸
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - rectSize: 容器的尺寸
    ///   - fontSize: 字体
    /// - Returns: 尺寸
    ///
    public func getStringSize(rectSize: CGSize,fontSize: CGFloat) -> CGSize {
        let str: NSString = self as NSString
        let rect = str.boundingRect(with: rectSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil)
        return CGSize(width: ceil(rect.width), height: ceil(rect.height))
    }
    /// 计算字符串尺寸
    ///
    /// - Parameter fontSize: 字体大小
    /// - Returns: 尺寸
    public func getStringSize(fontSize:CGFloat) -> CGSize {
        return self.getStringSize(rectSize: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), fontSize: fontSize)
    }
    /// 输入字符串 输出数组
    /// e.g  "qwert" -> ["q","w","e","r","t"]
    /// - Returns: ["q","w","e","r","t"]
    public func stringToArr() -> [String] {
        let num = count
        if !(num > 0) { return [""] }
        var arr: [String] = []
        for i in 0..<num {
            let tempStr: String = self[self.index(self.startIndex, offsetBy: i)].description
            arr.append(tempStr)
        }
        return arr
    }
    /// 字符串截取         3  6
    /// e.g let aaa = "abcdefghijklmnopqrstuvwxyz"  -> "cdef"
    /// - Parameters:
    ///   - start: 开始位置 3
    ///   - end: 结束位置 6
    /// - Returns: 截取后的字符串 "cdef"
    public func startToEnd(start: Int,end: Int) -> String {
        if !(end < count) || start > end { return "取值范围错误" }
        var tempStr: String = ""
        for i in start...end {
            let temp: String = self[self.index(self.startIndex, offsetBy: i - 1)].description
            tempStr += temp
        }
        return tempStr
    }
    /// 字符串修改部分为密文
    ///
    /// - Parameters:
    ///   - start: 开始位置
    ///   - end: 结束为止
    /// - Returns: 修改后的字符串
    func stringAddSecret(start: Int, end: Int) -> String {
        if !(end < count) || start > end { return "取值范围错误" }
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        let string = self.replacingCharacters(in: startIndex...endIndex, with: "****")
        return string
    }

    /// 字符URL格式化,中文路径encoding
    ///
    /// - Returns: 格式化的 url
    public func stringEncoding() -> String {
        let url = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return url!
    }
    ///是否包含字符串
    public func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    ///去除String中空格
    public func trim() -> String {
        return self.replacingOccurrences(of: " ", with: "").trimmingCharacters(in: CharacterSet.whitespaces)
    }
}

extension NSString {
    ///修改字符串中数字样式
    @objc
    public func attributeNumber(_ fontsize :CGFloat,color:UIColor,hcolor:UIColor,B:Bool) -> NSMutableAttributedString {
       return (self as String).attributeNumber(fontsize, color: color, hcolor: hcolor, B: B)
    }
}
extension String {
    /// 删除字符串中Unicode.Cc/Cf字符,类似于\0这种
    public func stringByRemovingControlCharacters() -> String {
        let controlChars = CharacterSet.controlCharacters
        var range = self.rangeOfCharacter(from: controlChars)
        var mutable = self
        while let removeRange = range {
            mutable.removeSubrange(removeRange)
            range = mutable.rangeOfCharacter(from: controlChars)
        }
        return mutable
    }
    /// 修改字符串中数字样式,将其加粗,变黑,加大4个字号,同时修改行间距
    ///
    /// - Parameters:
    ///   - fontsize: 非数字字号
    ///   - color: 非数字颜色
    ///   - lineSpace: 行间距
    /// - Returns: 修改完成的AttributedString
    public func attributeNumber(BoldFontSize fontsize:CGFloat, color:UIColor,lineSpace:CGFloat?) -> NSMutableAttributedString {
        let AttributedStr = NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: fontsize), .foregroundColor: color])
        for i in 0 ..< self.count {
            let char = self.utf8[self.index(self.startIndex, offsetBy: i)]
            if (char > 47 && char < 58) {
                AttributedStr.addAttribute(.foregroundColor, value: UIColor(red: 33 / 255.0, green: 34 / 255.0, blue: 35 / 255.0, alpha: 1), range: NSRange(location: i, length: 1))
                AttributedStr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: fontsize + 4), range: NSRange(location: i, length: 1))
            }
        }
        if let space = lineSpace {
            let paragraphStyleT = NSMutableParagraphStyle()
            paragraphStyleT.lineSpacing = space
            AttributedStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyleT, range: NSRange(location: 0, length: self.count))
        }
        return AttributedStr
    }
    /// 给字符串中数字变样式
    ///
    /// - Parameters:
    ///   - fontsize: 字体大小
    ///   - color: 非数字颜色
    ///   - hcolor: 数字颜色
    ///   - B: 是否加粗变大
    /// - Returns: 修改完成字符串
    public func attributeNumber(_ fontsize :CGFloat,color:UIColor,hcolor:UIColor,B:Bool) -> NSMutableAttributedString {
        let AttributedStr = NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: fontsize), .foregroundColor: color])
        for i in 0 ..< self.count {
            let char = self.utf8[self.index(self.startIndex, offsetBy: i)]
            if (char > 47 && char < 58) {
                AttributedStr.addAttribute(.foregroundColor, value: hcolor, range: NSRange(location: i, length: 1))
                if B {
                    AttributedStr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: fontsize + 2), range: NSRange(location: i, length: 1))
                }
            }
        }
        return AttributedStr
    }
}
// swiftlint:disable missing_docs
extension String {
    /// 字符串长度
    public var length: Int {
        ///更改成其他的影响含有emoji协议的签名
        return self.utf16.count
    }
    public var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    public var intValue: Int32 {
        return (self as NSString).intValue
    }
    public var floatValue: Float {
        return (self as NSString).floatValue
    }
    public var integerValue: Int {
        return (self as NSString).integerValue
    }
    public var longLongValue: Int64 {
        return (self as NSString).longLongValue
    }
    public var boolValue: Bool {
        return (self as NSString).boolValue
    }
}

/// String转换成URL
public protocol URLConvertibleProtocol {
    var URLValue: URL? { get }
    var URLStringValue: String { get }
}
extension String: URLConvertibleProtocol {
    /// String转换成URL
    public var URLValue: URL? {
        if let URL = URL(string: self) {
            return URL
        }
        let set = CharacterSet()
            .union(.urlHostAllowed)
            .union(.urlPathAllowed)
            .union(.urlQueryAllowed)
            .union(.urlFragmentAllowed)
        return self.addingPercentEncoding(withAllowedCharacters: set).flatMap { URL(string: $0) }
    }
    public var URLStringValue: String {
        return self
    }
}

extension String {
    /**
     将当前字符串拼接到cache目录后面
     */
    public func cacheDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到doc目录后面
     */
    public func docDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到tmp目录后面
     */
    public func tmpDir() -> String {
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
}

extension String {
    ///判断String是否存在汉字
    public func isIncludeChineseIn() -> Bool {
        for value in self {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
}

extension String {
    ///根据字符串获取字典
    public func stringValueDic() -> [String : Any]?{
        let data = self.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }
}

