//
//  DateUtils.swift
//  Digital Onboard
//
//  Created by Myo Zaw Oo on 19/08/2020.
//

import Foundation

class DateUtils {
    
    static func convertDate(date: String, fromDateFormat: String, toDateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromDateFormat
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en_US")
        let convertedDate = dateFormatter.date(from: date)
        guard dateFormatter.date(from: date) != nil else {
            return ""
        }
        dateFormatter.dateFormat = toDateFormat
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        return timeStamp
    }
}
