//
//  ViewController.swift
//  String+Extension
//
//  Created by Ethan.Wang on 2018/9/12.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit
var testString = "https://www.测试  123\0啦啦5.com"
class ViewController: UIViewController {

    let label1: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 200, width: UIScreen.main.bounds.width - 200, height: 150))
        label.backgroundColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    let label2:UILabel =  {
        let label = UILabel(frame: CGRect(x: 100, y: 400, width: UIScreen.main.bounds.width - 200, height: 150))
        label.backgroundColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        drawMyView()
        changeString()
    }
    func drawMyView(){
        self.view.addSubview(label1)
        self.view.addSubview(label2)
    }
    func changeString(){
        
        testString = testString.stringByRemovingControlCharacters()
        print("testString,去除字符串中的Cc/Cf字符: \(testString)\r")

        let string1 = testString.stringCut(end: 3)
        print("String1,截取到第三位: \(string1)\r")

        let string2 = testString.stringCutToEnd(star: 3)
        print("String2,从第三位截取到最后: \(string2)\r")

        let string3 = testString.stringCutLastEnd(last: 3)
        print("String3,截取最后三位: \(string3)\r")

        let string4 = testString.stringInsert(content: "插入汉字", locat: 3)
        print("String4,在第三位插入'插入汉字': \(string4)\r")

        let string5 = testString.startToEnd(start: 3, end: 6)
        print("String5,截取第三位到第六位: \(string5)\r")

        let string6 = testString.stringEncoding()
        print("String6,将汉字encoding: \(string6)\r")

        let string7 = testString.trim()
        print("String7,去除字符串中空格: \(string7)\r")

        let string8 = "String8,修改字符串中数字的大小,颜色并修改行距: \(testString)".attributeNumber(BoldFontSize: 16, color: UIColor.purple, lineSpace: 10)
        label1.attributedText = string8

        let string9 = "String9,修改字符串中数字的大小,颜色: \(testString)".attributeNumber(16, color: UIColor.blue, hcolor: UIColor.red, B: true)
        label2.attributedText = string9

        let string10 = testString.URLValue
        print("String10,字符串的URL化: \(string10!)\r")

        let string11 = testString.cacheDir()
        print("String11,将字符串拼接在cache路径后面: \(string11)\r")

        let string12 = testString.docDir()
        print("String12,将字符串拼接在doc路径后面: \(string12)\r")

        let string13 = testString.tmpDir()
        print("String14,将字符串拼接在tmp路径后面: \(string13)\r")

        let size1 = testString.getStringSize(fontSize: 14)
        print("Size1,获取字符串在14号字下大小: \(size1)\r")

        let array1 = testString.stringToArr()
        print("Array1,将字符串拆成数组: \(array1)\r")

        let bool1 = testString.containsIgnoringCase(find: "123")
        print("Bool1,判断字符串中是否含有'123': \(bool1)\r")

        let bool2 = testString.isIncludeChineseIn()
        print("Bool2,判断字符串中是否含有汉字: \(bool2)\r")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

