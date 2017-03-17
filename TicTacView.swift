//
//  TicTacView.swift
//  TicTacToe
//
//  Created by Andreas Umbach on 09.08.2015.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import UIKit


enum TickTackType: Int {
    case empty = 0, cross, circle
}

@IBDesignable class TickTackView : UIView
{
    @IBInspectable var elementColor : UIColor = UIColor.red {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var type : TickTackType = .cross {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var isHighlighted : Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    func reset()
    {
        self.type = .empty
        self.isHighlighted = false
    }
    
    @IBInspectable var boardPosition : Int = 0
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        
        if(self.isHighlighted)
        {
            ctx?.setStrokeColor(UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0).cgColor)
            ctx?.stroke(rect.insetBy(dx: 4.0, dy: 4.0), width: 3.0 )
        }
        
        switch self.type
        {
        case .circle:
            let outerCircle = CGMutablePath()
            outerCircle.addEllipse(in: rect.insetBy(dx: rect.width * 0.1, dy: rect.height * 0.1))
            ctx?.addPath(outerCircle)
            ctx?.setFillColor(elementColor.cgColor)
            ctx?.fillPath()
            
            let innerCircle = CGMutablePath()
            innerCircle.addEllipse(in: rect.insetBy(dx: rect.width * 0.2, dy: rect.height * 0.2))
            ctx?.addPath(innerCircle)
            ctx?.setFillColor(UIColor.white.cgColor)
            ctx?.fillPath()
            
        case .cross:
            let path = CGMutablePath()
            let d : CGFloat = 0.1
            let r = rect.insetBy(dx: rect.width * 0.1, dy: rect.height * 0.1)
            let m = CGAffineTransform(translationX: rect.width * 0.1, y: rect.height * 0.1)
            
            path.move(to: CGPoint(x: r.width * d, y: 0), transform: m)
            path.addLine(to: CGPoint(x: 0, y: r.height * d), transform: m)
            path.addLine(to: CGPoint(x: r.width * (1-d), y : r.height), transform: m)
            path.addLine(to: CGPoint(x: r.width, y: r.height * (1-d)), transform: m)
            path.closeSubpath()
            
            path.move(to: CGPoint(x: r.width * (1-d), y: 0), transform: m)
            path.addLine(to: CGPoint(x: 0, y: r.height * (1-d)), transform: m)
            path.addLine(to: CGPoint(x: r.width * d, y : r.height), transform: m)
            path.addLine(to: CGPoint(x: r.width, y: r.height * d), transform: m)
            path.closeSubpath()
            
            ctx?.addPath(path)
            ctx?.setFillColor(elementColor.cgColor)
            ctx?.fillPath()
        case .empty:
            break
        }
    }
    
}
