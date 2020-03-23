//
//  StringExtension.swift
//  HealthyHome
//
//  Created by apple on 2020/3/23.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

public extension String {

    /// 字符串截取函数
    func subToString(to index: Int) -> String {
        if index >= self.count {
            return String(self[..<self.index(self.startIndex, offsetBy: self.count)])
        }
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    /// 字符串截取函数
    func subFromString(from index: Int) -> String {
        if index >= self.count {
            return String(self[self.index(self.startIndex, offsetBy: self.count)...])
        }
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    func subOffSetString(from index: Int, offSet: Int) -> String {
        let begin = self.id_subString(from: index)
        let str = begin.id_subString(to: offSet)
        return str
    }
    
    /// range转换为NSRange
    func rangeLocLength(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
}
