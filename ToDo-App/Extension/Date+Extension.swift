//
//  Date+Extension.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/25/21.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
