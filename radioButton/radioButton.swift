//
//  radioButton.swift
//  radioTest
//
//  Created by 陳建佑 on 15/08/2017.
//  Copyright © 2017 陳建佑. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class radioButton: UIControl {
    
    // MARK: Parameter
    let titleLabel = UILabel()
    @IBInspectable var title: String = "hj" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    @IBInspectable var color: UIColor = UIColor.black {
        didSet {
            self.titleLabel.textColor = color
            self.outterLayer.strokeColor = color.cgColor
        }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.black {
        didSet {
            self.innerLayer.fillColor = fillColor.cgColor
        }
    }
    
    private var paddingConstraint = NSLayoutConstraint()
    @IBInspectable var padding: CGFloat = 5.0 {
        didSet {
            let fontHeight = self.titleLabel.font.lineHeight
            let constant = fontHeight + padding
            if constant >= 0 {
                self.paddingConstraint.constant = constant
                self.layoutIfNeeded()
            }
        }
    }
    
    private var mylineWidth: CGFloat = 1.0
    @IBInspectable var lineWidth: CGFloat {
        set {
            self.mylineWidth = (newValue >= 1) ? newValue: 1
            
            self.outterLayer.lineWidth = self.mylineWidth
            self.layoutIfNeeded()
        }
        get {
            return self.mylineWidth
        }
    }
    
    private var myInnerMultiple: CGFloat = 1.0
    @IBInspectable var innerMultiple: CGFloat {
        set {
            self.myInnerMultiple = (newValue >= 0) ? newValue: 0.1
            
            if self.radioSelected {
                self.innerLayer.removeFromSuperlayer()
                self.innerLayerInit()
            }
        }
        get {
            return self.myInnerMultiple
        }
    }
    
    private var myTextSize: CGFloat = 17.0
    @IBInspectable var textSize: CGFloat {
        set {
            myTextSize = (newValue >= 1) ? newValue: 1
            self.titleLabel.font = self.titleLabel.font.withSize(myTextSize)
            
            self.outterLayer.removeFromSuperlayer()
            self.radioInit()
            
            let fontHeight = self.titleLabel.font.lineHeight
            self.paddingConstraint.constant = fontHeight + self.padding
        }
        get {
            return self.myTextSize
        }
    }
    
    @IBInspectable var radioSelected: Bool = false {
        didSet {
            (radioSelected) ? self.innerLayerInit(): self.innerLayer.removeFromSuperlayer()
            self.layoutIfNeeded()
        }
    }
    
    private var outterLayer = CAShapeLayer()
    private var innerLayer = CAShapeLayer()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewInit()
        self.improvePerformance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewInit()
        self.improvePerformance()
    }
    
    /// Change view settings for faster drawing
    private func improvePerformance() {
        /// Cache the view into a bitmap instead of redrawing the stars each time
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        isOpaque = true
    }
    
    private func viewInit() {
        self.lineWidth = 1.0
        self.titleLabelInit()
        self.radioInit()
        
        print("f")
    }
    
    private func titleLabelInit() {
        self.addSubview(self.titleLabel)
        self.titleLabel.textAlignment = .center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let fontHeight = self.titleLabel.font.lineHeight
        
        // right
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        
        // left
        self.paddingConstraint = NSLayoutConstraint(item: self.titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: fontHeight + self.padding)
        self.addConstraint(self.paddingConstraint)
        
        // Top
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        
        // Down
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.titleLabel.setContentCompressionResistancePriority(1000, for: .horizontal)
        self.titleLabel.setContentCompressionResistancePriority(1000, for: .vertical)
        self.layoutIfNeeded()
    }
    
    private func radioInit() {
        let fontHeight = self.titleLabel.font.lineHeight
        let frameHeight = self.frame.size.height
        let ctr_y = (frameHeight == 0) ? fontHeight/2: frameHeight/2
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: fontHeight/2 ,y: ctr_y), radius: fontHeight*0.35, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        self.outterLayer.path = circlePath.cgPath
        self.outterLayer.rasterizationScale = UIScreen.main.scale
        self.outterLayer.shouldRasterize = true
        self.outterLayer.lineWidth = self.lineWidth
        self.outterLayer.fillColor = nil
        self.outterLayer.strokeColor = self.color.cgColor
        self.layer.addSublayer(self.outterLayer)
    }
    
    private func innerLayerInit() {
        let fontHeight = self.titleLabel.font.lineHeight
        let frameHeight = self.frame.size.height
        let ctr_y = (frameHeight == 0) ? fontHeight/2: frameHeight/2
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: fontHeight/2 ,y: ctr_y), radius: fontHeight*0.35*self.innerMultiple, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        self.innerLayer.path = circlePath.cgPath
        self.innerLayer.rasterizationScale = UIScreen.main.scale
        self.innerLayer.shouldRasterize = true
        self.innerLayer.lineWidth = self.lineWidth
        self.innerLayer.fillColor = self.fillColor.cgColor
        self.innerLayer.strokeColor = nil
        self.layer.addSublayer(self.innerLayer)
    }
}
