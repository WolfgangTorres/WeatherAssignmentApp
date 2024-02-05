//
//  WeatherReusableView.swift
//  WeatherAssignmentApp
//
//  Created by Andres Torres on 03/02/24.
//

import UIKit

// This class represents a reusable view for displaying weather information.
// It's designed to be used in Interface Builder
@IBDesignable
final class WeatherReusableView: UIView {
    
    // MARK: - IBOutlets
    
    // Labels to display the title and value in the weather view.
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - IBInspectable properties
    
    // Allows corner radius of the view to be set from the Interface Builder.
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    // Allows border width of the view to be set from the Interface Builder.
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    // Allows border color of the view to be set from the Interface Builder.
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    // MARK: - Initializers
    
    // Initializes the view.
    // This initializer is called when a view is created programmatically.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    // Initializes the view from a storyboard or xib file.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    // MARK: - Private functions
    
    // Loads the view from the corresponding nib file and sets it up.
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "WeatherReusableView") else {
            return
        }
        
        view.frame = self.bounds
        
        self.addSubview(view)
    }
    
    // Configures the font size of the labels to be dynamic, supporting Dynamic Type.
    private func configureDynamicType() {
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        self.valueLabel.adjustsFontForContentSizeCategory = true
        self.valueLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    // MARK: - Public functions
    
    // Configures the view with specific title and value,
    // and ensures the labels support Dynamic Type.
    func configure(title: String, value: String) {
        self.configureDynamicType()
        
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
}
