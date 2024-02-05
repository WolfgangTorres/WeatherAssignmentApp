//
//  String+Extension.swift
//  WeatherAssignmentApp
//
//  Created by Andres Torres on 03/02/24.
//

import Foundation

extension String {
    
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
    
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
}
