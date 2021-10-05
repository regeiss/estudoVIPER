//
//  DataHora.swift
//  estudoVIPER
//
//  Created by Roberto Edgar Geiss on 01/10/21.
//

import Foundation

class DataHora
{
    class func parseYMD(dateString: Any?) -> DateComponents?
    {
        guard let str = dateString as? String else {
            return nil
        }
        guard let dateTS = PostDatabaseAssumption.ymdDateFormatter.date(from: str)
        else {
            return nil
        }
        let dateComps = PostDatabaseAssumption.calendar.dateComponents([.year, .month, .day], from: dateTS)
        return dateComps
    }

    class func formatYMD(dateValue: Any?) -> String?
    {
        guard let date = dateValue as? Date
        else {
            return nil
        }
        let dateStr = PostDatabaseAssumption.ymdDateFormatter.string(from: date)
        return dateStr
    }
}
