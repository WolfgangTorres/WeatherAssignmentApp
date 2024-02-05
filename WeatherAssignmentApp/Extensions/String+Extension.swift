//
//  String+Extension.swift
//  WeatherAssignmentApp
//
//  Created by Andres Torres on 03/02/24.
//

import Foundation

// Extension to the String class to add functionality
// related to date format conversion and localization.
extension String {
    
    /**
     Converts a date string from one format to another.
     Useful when you need to present dates in a user-friendly format.
     
     - Parameters:
        - inputFormat: A string representing the date format of the calling string. Defaults to ISO8601 format.
        - outputFormat: A string representing the desired output date format.
     - Returns: A new string representing the date in the new format, or "Invalid date format" if conversion fails.
     */
    func convertDateFormat(
        from inputFormat: String = "yyyy-MM-dd'T'HH:mm",
        to outputFormat: String
    ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        guard let date = dateFormatter.date(from: self) else {
            return "Invalid date format"
        }
        
        dateFormatter.dateFormat = outputFormat
        
        return dateFormatter.string(from: date)
    }
    
    /**
     Retrieves a localized version of the string, using the standard localization process.
     
     - Returns: A localized version of the string if it exists in the Localizable.strings file, otherwise returns the original string.
     */
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
}
