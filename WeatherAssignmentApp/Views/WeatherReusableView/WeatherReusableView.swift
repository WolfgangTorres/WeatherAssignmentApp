//
//  WeatherReusableView.swift
//  WeatherAssignmentApp
//
//  Created by Andres Torres on 03/02/24.
//

import UIKit

@IBDesignable
final class WeatherReusableView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "WeatherReusableView") else {
            return
        }
        
        view.frame = self.bounds
        
        self.addSubview(view)
    }
    
    private func configureDynamicType() {
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        self.valueLabel.adjustsFontForContentSizeCategory = true
        self.valueLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    func configure(title: String, value: String) {
        self.configureDynamicType()
        
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
}
