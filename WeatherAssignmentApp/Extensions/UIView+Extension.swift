//
//  UIView+Extension.swift
//  WeatherAssignmentApp
//
//  Created by Andres Torres on 03/02/24.
//

import UIKit

// This extension to UIView adds functionality to load a view from a nib file.
extension UIView {
    
    /**
     Loads a view from a nib file.
     This method is particularly useful when creating reusable views that are designed in Interface Builder.
     - Parameter nibName: The name of the nib file (without the .xib extension) from which to load the view.
     - Returns: An instance of the view loaded from the nib file, or nil if the process fails.
     */
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self).first as? UIView
    }
}
