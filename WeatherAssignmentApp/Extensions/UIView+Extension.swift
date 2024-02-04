//
//  UIView+Extension.swift
//  WeatherAssignmentApp
//
//  Created by Andres Torres on 03/02/24.
//

import UIKit

extension UIView {
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self).first as? UIView
    }
}
