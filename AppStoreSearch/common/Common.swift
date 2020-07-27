//
//  Common.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class Common: NSObject {
    
    static let recentSearchKey:String = "RECENT_SEARCH_KEYWORD"
    
    
    // MARK: - Recent Search List
    // get
    class func getRecentSearchList() -> [String] {
        return UserDefaultManager.getUserDefault(key: recentSearchKey) ?? []
    }
    
    // set
    class func setRecentSearchList<T>(value: T) {
        UserDefaultManager.setUserDefault(key: recentSearchKey, value: value)
    }
    
    
    
    // MARK: - functions
    // url encoding
    class func stringByAddingPercentEncoding(text: String) -> String {
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: "*-._")
        allowed.insert(charactersIn: " ")
        
        var encoded = text.addingPercentEncoding(withAllowedCharacters: allowed)
        encoded = encoded?.replacingOccurrences(of: " ", with: "+")
        return encoded ?? ""
    }
    
    // 소숫점 몇째자리(count) 까지 반올림 -> 문자로 반환
    class func roundFloat(number: CGFloat, count: Int = 0) -> String {
        return String(format: "%.\(count)f", number)
    }
    
    // screnn url -> size
    class func getImageSizeWithUrl(url: String) -> CGSize {
        var width:CGFloat = 300
        var height:CGFloat = 600
        
        // https://is3-ssl.mzstatic.com/image/thumb/Purple113/v4/95/cc/de/95ccde69-2040-598f-7c09-a79ddb982cb4/pr_source.png/392x696bb.png
        if let fileName:String = url.components(separatedBy: "/").last,             // 392x696bb.png
            let sizeStr:String = fileName.components(separatedBy: "bb.").first,     // 392x696
            sizeStr.components(separatedBy: "x").count > 1 {
            
            let sizeArr:[String] = sizeStr.components(separatedBy: "x")             // [392, 696]
            
            width = CGFloat(Int(sizeArr[0]) ?? 300)
            height = CGFloat(Int(sizeArr[1]) ?? 600)
        }
        return CGSize(width: width, height: height)
    }
    
    // 현재 시간과 비교한 문자열 반환
    class func getDiffDateString(dateStr: String) -> String {
        // 2020-07-05T23:31:29Z -> %d일 %d시간 전 반환
        var returnStr:String = ""

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = formatter.date(from: dateStr) {
            
            let calendar = Calendar.current
            let calendarComponents: Set<Calendar.Component> = [.day, .hour]
            let offsetComps = calendar.dateComponents(calendarComponents, from: date, to: Date.init())
            
            if case let ( day?, hour?) = (offsetComps.day, offsetComps.hour) {
                if day > 0 {
                    returnStr = "\(day)일 "
                }
                if hour > 0 {
                    returnStr += "\(hour)시간 전"
                }
            }
        }
        return returnStr
    }
    
    // 날짜 포맷 변경
    class func getDateString(dateStr: String) -> String {
        // 2020-07-05T23:31:29Z -> 2020.07.05
        var returnStr:String = ""

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = formatter.date(from: dateStr) {
            formatter.dateFormat = "yyyy.MM.dd"
            returnStr = formatter.string(from: date)
        }
        return returnStr
    }

    // 숫자(1000000)를 입력 받아 decimal 스트링(1,000,000)으로 반환
    class func priceStr(_ value: CGFloat) -> String {
        if value == 0 {
            return "0"
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedString = formatter.string(for: value)
        
        return formattedString ?? "-"
    }
    
    // 숫자 포맷 (천, 만 단위)
    class func kmFormatStr(value: Int) -> String {
        var str:String = ""
        let absReward = abs(value)
        
        // - 처리
        if value < 0 {
            str += "-"
        }
        
        switch absReward {
        case 0..<1000: // 천 미만
            str += Common.priceStr(CGFloat(absReward))
            
        case ..<10000: // 천 이상 만 미만
            let thousandNum:CGFloat = CGFloat(absReward) / 1000;
            let floorValue = floor(thousandNum * 10) / 10
            str += "\(Common.priceStr(floorValue))천"
            
        default: // 만 이상
            let millionNum:CGFloat = CGFloat(absReward) / 10000;
            let floorValue = floor(millionNum * 1) / 1
            str += "\(Common.priceStr(floorValue))만"
        }
        
        return str
    }
    
    // show alert
    class func showConfirm(vc: UIViewController, title:String, message: String, callback:(() -> Void)? = nil) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "확인", style: .default, handler: {
            (alertAction) -> Void in
            callback?()
        }))
                    
        vc.present(alertView, animated: true, completion: nil)
    }
    
}



// MARK: - functions
func LOG(filename: String = #file, line: Int = #line, funcname: String = #function, _ output: String) {
    NSLog("[LOG] \(filename.components(separatedBy: "/").last ?? "") > \(funcname)(\(line)) :: \n\(output)")
}
