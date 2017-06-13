//
//  radioButton.swift
//  radioButton
//
//  Created by 陳建佑 on 13/06/2017.
//  Copyright © 2017 陳建佑. All rights reserved.
//

import UIKit

@IBDesignable
class radioButton: UIButton {
    
    @IBInspectable var lineColor: UIColor = UIColor.black {
        didSet {
            guard lineColor == lineColor else {return}
            
            if lineColor != oldValue {
                self.drawCircle()
            }
        }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.blue {
        didSet {
            guard fillColor == fillColor else {return}
            
            if fillColor != oldValue {
                self.drawCircle()
            }
        }
    }
    
    @IBInspectable var padding: CGFloat = 5.0 {
        didSet {
            guard padding == padding else {return}
            if padding != oldValue {
                self.drawCircle()
            }
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 1 {
        didSet {
            guard lineWidth == lineWidth else {return}
            if lineWidth != oldValue {
                self.drawCircle()
            }
        }
    }
    
    private var circleLayer = CAShapeLayer()
    private var centerLayer = CAShapeLayer()
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.improvePerformance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.improvePerformance()
    }
    
    /// Change view settings for faster drawing
    private func improvePerformance() {
        /// Cache the view into a bitmap instead of redrawing the stars each time
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        isOpaque = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.drawCircle()
    }
    
    func drawCircle() {
        
        let textFrame = self.titleLabel?.frame
        let frame = self.frame
        
        
        if textFrame!.origin.x + self.padding < textFrame!.size.height {
            let diff = textFrame!.size.height + self.padding - textFrame!.origin.x
            let newW = frame.size.width + diff
            self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newW, height: frame.size.height)
            return
        }
        
        let radius = (textFrame?.size.height)! * 0.6 / 2
        let ctr_x = (textFrame?.origin.x)! - (radius + self.padding)
        let ctr_y = frame.size.height / 2

        if (self.layer.sublayers?.contains(self.circleLayer))! {
            let idx = self.layer.sublayers?.index(of: self.circleLayer)
            self.layer.sublayers?.remove(at: idx!)
        }
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: ctr_x ,y: ctr_y), radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        self.circleLayer.path = circlePath.cgPath
        
        //change the fill color
        self.circleLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        self.circleLayer.strokeColor = self.lineColor.cgColor
        //you can change the line width
        self.circleLayer.lineWidth = self.lineWidth
        
        self.layer.addSublayer(self.circleLayer)
        
        self.drawCenter(ctr_x: ctr_x, ctr_y: ctr_y, radius: radius)
    }
    
    func drawCenter(ctr_x: CGFloat, ctr_y: CGFloat, radius: CGFloat) {
        
        if (self.layer.sublayers?.contains(self.centerLayer))! {
            let idx = self.layer.sublayers?.index(of: self.centerLayer)
            self.layer.sublayers?.remove(at: idx!)
        }
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: ctr_x ,y: ctr_y), radius: radius * 0.5, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        self.centerLayer.path = circlePath.cgPath
        
        //change the fill color
        self.centerLayer.fillColor = self.fillColor.cgColor
        //you can change the stroke color
        self.centerLayer.strokeColor = self.fillColor.cgColor
        //you can change the line width
        self.centerLayer.lineWidth = 1
        
        self.layer.addSublayer(self.centerLayer)
        
        self.centerLayer.isHidden = (self.isSelected) ? false: true
        
    }
}
