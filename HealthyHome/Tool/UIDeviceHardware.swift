//
//  UIDeviceHardware.swift
//  HealthyHome
//
//  Created by yyj on 2020/3/6.
//  Copyright © 2020 apple. All rights reserved.
//  git地址:https://github.com/ashleymills/Reachability.swift

import UIKit
import Reachability


class UIDeviceHardware: NSObject {
    
    //获取IP地址
    class func deviceIP() -> String {
        let reachablity = try!Reachability()
        if reachablity.connection == .wifi {
            return wifiIP()
        }
        return ipAddresses()
    }
    
    //获取无线WiFi的IP
    class func wifiIP() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else {
            return "0.0.0.0"
        }
        guard let firstAddr = ifaddr else {
            return "0.0.0.0"
        }
         
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            // Check for IPV4 or IPV6 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    // Convert interface address to a human readable string
                    var addr = interface.ifa_addr.pointee
                    var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr,socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostName)
                }
            }
        }
         
        freeifaddrs(ifaddr)
        return address ?? "0.0.0.0"
    }
    
    //MARK: 获取当前设备移动IP地址
    class func ipAddresses() -> String {
        
        var addresses = [String]()

        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first ?? "0.0.0.0"
    }
    
    
    //MARK: 手机型号
    class func deviceType() -> String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
                return String(cString: ptr)
            }
        if platform.contains("iPhone") {
            if platform == "iPhone1,1"    {return "iPhone 2G"}
            if platform == "iPhone1,2"    {return "iPhone 3G"}
            if platform == "iPhone2,1"    {return "iPhone 3GS"}
            if platform == "iPhone3,1"    {return "iPhone 4"}
            if platform == "iPhone3,2"    {return "iPhone 4"}
            if platform == "iPhone3,3"    {return "iPhone 4"}
            if platform == "iPhone4,1"    {return "iPhone 4S"}
            if platform == "iPhone5,1"    {return "iPhone 5"}
            if platform == "iPhone5,2"    {return "iPhone 5"}
            if platform == "iPhone5,3"    {return "iPhone 5c"}
            if platform == "iPhone5,4"    {return "iPhone 5c"}
            if platform == "iPhone6,1"    {return "iPhone 5s"}
            if platform == "iPhone6,2"    {return "iPhone 5s"}
            if platform == "iPhone7,2"    {return "iPhone 6"}
            if platform == "iPhone7,1"    {return "iPhone 6 Plus"}
            if platform == "iPhone8,1"    {return "iPhone 6s"}
            if platform == "iPhone8,2"    {return "iPhone 6s Plus"}
            if platform == "iPhone8,4"    {return "iPhone SE"}
            if platform == "iPhone9,1"    {return "iPhone 7"}
            if platform == "iPhone9,3"    {return "iPhone 7"}
            if platform == "iPhone9,2"    {return "iPhone 7 Plus"}
            if platform == "iPhone9,4"    {return "iPhone 7 Plus"}
            //2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
            if platform == "iPhone10,1"  {return "iPhone 8"}
            if platform == "iPhone10,4"  {return "iPhone 8"}
            if platform == "iPhone10,2"  {return "iPhone 8 Plus"}
            if platform == "iPhone10,5"  {return "iPhone 8 Plus"}
            if platform == "iPhone10,3"  {return "iPhone X"}
            if platform == "iPhone10,6"  {return "iPhone X"}
            //2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
            if platform == "iPhone11,8"  {return  "iPhone XR"}
            if platform == "iPhone11,2"  {return "iPhone XS"}
            if platform == "iPhone11,4"  {return "iPhone XS Max"}
            if platform == "iPhone11,6"  {return "iPhone XS Max"}
            //2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
            if platform == "iPhone12,1"  {return  "iPhone 11"}
            if platform == "iPhone12,3"  {return  "iPhone 11 Pro"}
            if platform == "iPhone12,5"  {return  "iPhone 11 Pro Max"}
            
            return "Unknown iPhone"
        }
        
        if platform.contains("iPad") {
            
            if platform == "iPad1,1"   {return "iPad"}
            if platform == "iPad1,2"   {return "iPad 3G"}
            if platform == "iPad2,1"   {return "iPad 2 (WiFi)"}
            if platform == "iPad2,2"   {return "iPad 2"}
            if platform == "iPad2,3"   {return "iPad 2 (CDMA)"}
            if platform == "iPad2,4"   {return "iPad 2"}
            if platform == "iPad2,5"   {return "iPad Mini (WiFi)"}
            if platform == "iPad2,6"   {return "iPad Mini"}
            if platform == "iPad2,7"   {return "iPad Mini (GSM+CDMA)"}
            if platform == "iPad3,1"   {return "iPad 3 (WiFi)"}
            if platform == "iPad3,2"   {return "iPad 3 (GSM+CDMA)"}
            if platform == "iPad3,3"   {return "iPad 3"}
            if platform == "iPad3,4"   {return "iPad 4 (WiFi)"}
            if platform == "iPad3,5"   {return "iPad 4"}
            if platform == "iPad3,6"   {return "iPad 4 (GSM+CDMA)"}
            if platform == "iPad4,1"   {return "iPad Air (WiFi)"}
            if platform == "iPad4,2"   {return "iPad Air (Cellular)"}
            if platform == "iPad4,4"   {return "iPad Mini 2 (WiFi)"}
            if platform == "iPad4,5"   {return "iPad Mini 2 (Cellular)"}
            if platform == "iPad4,6"   {return "iPad Mini 2"}
            if platform == "iPad4,7"   {return "iPad Mini 3"}
            if platform == "iPad4,8"   {return "iPad Mini 3"}
            if platform == "iPad4,9"   {return "iPad Mini 3"}
            if platform == "iPad5,1"   {return "iPad Mini 4 (WiFi)"}
            if platform == "iPad5,2"   {return "iPad Mini 4 (LTE)"}
            if platform == "iPad5,3"   {return "iPad Air 2"}
            if platform == "iPad5,4"   {return "iPad Air 2"}
            if platform == "iPad6,3"   {return "iPad Pro 9.7"}
            if platform == "iPad6,4"   {return "iPad Pro 9.7"}
            if platform == "iPad6,7"   {return "iPad Pro 12.9"}
            if platform == "iPad6,8"   {return "iPad Pro 12.9"}
            if platform == "iPad6,11"  {return "iPad 5 (WiFi)"}
            if platform == "iPad6,12"  {return "iPad 5 (Cellular)"}
            if platform == "iPad7,1"   {return "iPad Pro 12.9 inch 2nd gen (WiFi)"}
            if platform == "iPad7,2"   {return "iPad Pro 12.9 inch 2nd gen (Cellular)"}
            if platform == "iPad7,3"   {return "iPad Pro 10.5 inch (WiFi)"}
            if platform == "iPad7,4"   {return "iPad Pro 10.5 inch (Cellular)"}
            if platform == "iPad7,5"   {return "iPad (6th generation)"}
            if platform == "iPad7,6"   {return "iPad (6th generation)"}
            if platform == "iPad8,1"   {return "iPad Pro (11-inch)"}
            if platform == "iPad8,2"   {return "iPad Pro (11-inch)"}
            if platform == "iPad8,3"   {return "iPad Pro (11-inch)"}
            if platform == "iPad8,4"   {return "iPad Pro (11-inch)"}
            if platform == "iPad8,5"   {return "iPad Pro (12.9-inch) (3rd generation)"}
            if platform == "iPad8,6"   {return "iPad Pro (12.9-inch) (3rd generation)"}
            if platform == "iPad8,7"   {return "iPad Pro (12.9-inch) (3rd generation)"}
            if platform == "iPad8,8"   {return "iPad Pro (12.9-inch) (3rd generation)"}
            //2019年3月发布:
            if platform == "iPad11,1"   {return "iPad mini (5th generation)"}
            if platform == "iPad11,2"   {return "iPad mini (5th generation)"}
            if platform == "iPad11,3"   {return "iPad Air (3rd generation)"}
            if platform == "iPad11,4"   {return "iPad Air (3rd generation)"}

            return "Unknown iPad"
        }
        
        if platform.contains("iPod") {
            if platform == "iPod1,1"      {return "iPod Touch 1G"}
            if platform == "iPod2,1"      {return "iPod Touch 2G"}
            if platform == "iPod3,1"      {return "iPod Touch 3G"}
            if platform == "iPod4,1"      {return "iPod Touch 4G"}
            if platform == "iPod5,1"      {return "iPod Touch (5th generation)"}
            if platform == "iPod7,1"      {return "iPod touch (6th generation)"}
            //2019年5月发布，更新三种机型：iPod touch (7th generation)
            if platform == "iPod9,1"      {return "iPod touch (7th generation)"}

            return "Unknown iPod"
        }
        
        if platform.contains("i386") || platform.contains("x86_64") {
            return "Simulator"
        }
        
        return "Unknown iOS Device"
    }
    
    
}
