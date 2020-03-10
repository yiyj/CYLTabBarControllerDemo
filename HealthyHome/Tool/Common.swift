//
//  Common.swift
//  yyj
//
//  Created by apple on 2020/2/11.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AdSupport //广告

class Common: NSObject {
    
    //MARK: - 时间
    /*********时间***********/
    //MARK:获取当前时间
    class func nowTime(fromatter: String) -> String {
        let date = NSDate()
        //日期格式
        let dfromatter = DateFormatter()
        dfromatter.dateFormat = fromatter
        return dfromatter.string(from: date as Date)
    }
        
    //MARK:获取当前的时间戳
    class func dateTimeIntervalSinceNow()->TimeInterval {
        //获取当前时间
        let now = Date()
        let dfromatter = DateFormatter()
        dfromatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //当前时间的时间戳
        let dateStamp: TimeInterval = now.timeIntervalSince1970
        
        return dateStamp
    }
    
    //MARK: 时间字符串转时间戳
    class func stringToTimeStamp(stringTime: String, fromatter: String) -> TimeInterval {
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = fromatter
        let date = dformatter.date(from: stringTime)
        let dateStamp: TimeInterval = date?.timeIntervalSince1970 ?? 0
        
        return dateStamp
    }
    
    //MARK:日期:String转Date
    class func stringToDate(string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        
        //根据本地时区转换
        //设置源日期时区
        let sourceTimeZone = NSTimeZone(abbreviation: "UTC")
        //或GMT
        //设置转换后的目标日期时区
        let destinationTimeZone = NSTimeZone.local as NSTimeZone
        //得到源日期与世界标准时间的偏移量
        var sourceGMTOffset: Int? = nil
        if let aDate = date {
            sourceGMTOffset = sourceTimeZone?.secondsFromGMT(for: aDate)
        }
        //目标日期与本地时区的偏移量
        var destinationGMTOffset: Int? = nil
        if let aDate = date {
            destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: aDate)
        }
        //得到时间偏移量的差值
        let interval = TimeInterval((destinationGMTOffset ?? 0) - (sourceGMTOffset ?? 0))
        //转为现在时间
        var destinationDateNow: Date? = nil
        if let aDate = date {
            destinationDateNow = Date(timeInterval: interval, since: aDate)
        }
        return destinationDateNow!
    }
    
    //MARK:获取当期日期前几天的日期
    class func beforeNowDays(days: Int) -> [String] {
        var arr: [String] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year, .month, .day], from: Date())
        var dateCom = DateComponents()
        for i in 1...days {
            dateCom.day = com.day! - i
            dateCom.month = com.month
            dateCom.year = com.year
            let day = calendar.date(from: dateCom)
            
            arr.append(dateFormatter.string(from: day!))
        }
        return arr
    }
    
    //MARK:获取某个日期前几天的日期
    class func timebeforeDays(time: String, days: Int) -> [String] {
        var arr: [String] = []
        
        let formater = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formater
        let calendar = NSCalendar.current
        
        let date = stringToDate(string: time, dateFormat: formater)
        
        let com = calendar.dateComponents([.year, .month, .day], from: date)
        var dateCom = DateComponents()
        for i in 1...days {
            dateCom.day = com.day! - i
            dateCom.month = com.month
            dateCom.year = com.year
    
            let day = calendar.date(from: dateCom)
            
            arr.append(dateFormatter.string(from: day!))
        }
        return arr
    }
    
    //获取当前日期的前一个月的日期
    class func beforeMonth(formater: String = "yyyy-MM-dd") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formater
        let calendar = NSCalendar.current
        
        let com = calendar.dateComponents([.year, .month, .day], from: Date())
        var dateCom = DateComponents()
        
        dateCom.day = com.day!
        dateCom.month = com.month! - 1
        dateCom.year = com.year
        
        let day = calendar.date(from: dateCom)
        
        return dateFormatter.string(from: day!)       
    }
    
    
    
    //MARK: 星期几
    class func weekdayStringFromTime(dateTime:String, fromatter: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let weekdays = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]

        let dateFmt = DateFormatter()
        dateFmt.dateFormat = fromatter
        let date = dateFmt.date(from: dateTime)
        
        //根据本地时区转换
        //设置源日期时区
        let sourceTimeZone = NSTimeZone(abbreviation: "UTC") //UTC时间，即0时区的时间
        //或GMT
        //设置转换后的目标日期时区
        let destinationTimeZone = NSTimeZone.local as NSTimeZone
        //得到源日期与世界标准时间的偏移量
        var sourceGMTOffset: Int? = nil
        if let aDate = date {
            sourceGMTOffset = sourceTimeZone?.secondsFromGMT(for: aDate)
        }
        //目标日期与本地时区的偏移量
        var destinationGMTOffset: Int? = nil
        if let aDate = date {
            destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: aDate)
        }
        //得到时间偏移量的差值
        let intervalOffset = TimeInterval((destinationGMTOffset ?? 0) - (sourceGMTOffset ?? 0))
        
        let interval = Int(date?.timeIntervalSince1970 ?? 0) + Int(intervalOffset)
        
        let days = Int(interval/86400) // 24*60*60
        //timeIntervalSince1970是取当前日期和1970-01-01 0点的时间差，当天是星期四,输入年份小于1970时interval以及days有可能为负数，因此模7取余后，又进行了加7和模7
        let weekday = ((days + 4)%7 + 7)%7
        print(weekday)
        return weekdays[weekday]
    }
    
    
    //MARK:各种格式判断
    /**
     * 输入数字，大写字母和小写字母(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$ 位数判断
     *  text：文本字符
     *  min：最小位数
     *  max：最大位数
     */
    class func isNumberOrCharterStyle(text:String, min: Int, max: Int) -> Bool {
        let regex = "(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{\(min),\(max)}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: text)
        return (isValid ? true : false)
    }
    
    /**
    *   判断只能输入数字或字母的位数[0-9a-zA-Z]{4,20}
    *   text：文本字符
    *   min：最小位数
    *   max：最大位数
    */
    class func isNumberOrLettersCount(text: String, min: Int, max: Int) -> Bool {
        let regex = "[0-9a-zA-Z]{\(min),\(max)}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: text)
        return (isValid ? true : false)
    }
    
    /**
    *   判断输入是否全为纯数字
    */
    class func isNumberOfText(text: String) -> Bool {
        let scan: Scanner = Scanner(string: text)
        var val: Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    /**
    *   判断只能输入纯数字位数
    */
    class func inputTextCount(text: String, count: Int) -> Bool {
        let regex = "^[0-9]{\(count)}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: text)
        return (isValid ? true : false)
    }
    
    /**
    *   判断中英文输入
    */
    class func isChineseAndEnglish(text: String) -> Bool {
        let regex = "[\\u4e00-\\u9fa5a-zA-Z0-9]{4,20}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: text)
        return (isValid ? true : false)
    }
    
    /**
     *   判断邮箱格式
     */
    class func enterIsEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: email)
        return (isValid ? true : false)
    }
    
    /**
    *   base64解码
    */
    class func base64Decoding(encodedString: String) -> String {
        
        let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        
        return decodedString
    }
    
    //MARK:base64编码
    /**
     *   base64编码
     */
    class func base64Encoding(plainString:String)->String {
        if (plainString == "" || plainString.isEmpty || plainString.count == 0) {
            return "";
        }
        let plainData = plainString.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }

    // MARK: - 根据最大宽度计算宽高
    class func textSizeWithHight(text: String, maxWidth: CGFloat, font:UIFont) -> CGRect {
        //起始默认高度为0
        let maxSize = CGSize(width: maxWidth, height: 0)
        let normalText: NSString = text as NSString
        let size = normalText.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        
        return size
    }
    
    // MARK: - 字典转字符串
    class func dictToString(_ dict: [String: Any]) ->String {
        let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
        var dicStr = String(data: data!, encoding: String.Encoding.utf8)
        dicStr = dicStr?.replacingOccurrences(of: "/", with: "\\/")
        return dicStr ?? ""
    }
    
    //MARK: - 格式化字符串

    /// 获取两位小数点的字符串
    class func getFloat(string: String) -> String {
        if string == "" || string.isEmpty || string.count == 0 {
            return "0.00"
        }
        
        if !isNumberOfText(text: string) {
            print("请输入纯数字字符")
            return "0.00"
        }
        
        let sf: String = NSString.init(format: "%0.2f", Double(string)!) as String
        
        return sf
    }
    
    /// 获取整形字符串
    class func getInt(string: String) -> String {
        if string == "" || string.isEmpty || string.count == 0 {
            return "0"
        }
        
        let sf: String = NSString.init(format: "%d", Int(string)!) as String
        
        return sf
    }

    /// 判断是不是全是空格
    class func isAllApacing(string: String?) -> Bool {
        if string == nil {
            return true
        }
        
        let set = NSCharacterSet.whitespacesAndNewlines
        let trimedString = string?.trimmingCharacters(in: set)
        if trimedString?.count == 0 {
            return true
        }else {
            return false
        }
    }
    
    
    /**********获取设备唯一标示**********/
    //MARK:UUID
//    class func uuid() -> String {
//
//    }
    
    //MARK: 保存UUID
    class func saveUUIDToKeyChain() {
        
       
    }
    
    //MARK: IDFA
    /**直译就是广告id， 在同一个设备上的所有App都会取到相同的值，是苹果专门给各广告提供商用来追踪用户而设的，用户可以在 设置|隐私|广告追踪 里重置此id的值，或限制此id的使用，故此id有可能会取不到值，但好在Apple默认是允许追踪的，而且一般用户都不知道有这么个设置，所以基本上用来监测推广效果，是戳戳有余了。
     注意：由于idfa会出现取不到的情况，故绝不可以作为业务分析的主id，来识别用户
     */
    class func idfa() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    //MARK: IDFV
    /**
     给Vendor标识用户用的，每个设备在所属同一个Vender的应用里，都有相同的值。其中的Vender是指应用提供商，但准确点说，是通过BundleID的反转的前两部分进行匹配，如果相同就是同一个Vender，例如对于com.taobao.app1, com.taobao.app2 这两个BundleID来说，就属于同一个Vender，共享同一个idfv的值。和idfa不同的是，idfv的值是一定能取到的，所以非常适合于作为内部用户行为分析的主id，来标识用户，替代OpenUDID。
     注意 如果用户将属于此Vender的所有App卸载，则idfv的值会被重置，即再重装此Vender的App，idfv的值和之前不同。
     */
    class func idfv() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    
    
}

