//
//  TicTacView.swift
//  TicTacToe
//
//  Created by Andreas Umbach on 09.08.2015.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import UIKit


enum TickTackType: Int {
    case Empty = 0, Cross, Circle
}

@IBDesignable class TickTackView : UIView
{
    @IBInspectable var elementColor : UIColor = UIColor.redColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var type : TickTackType = .Cross {
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
        self.type = .Empty
        self.isHighlighted = false
    }
    
    @IBInspectable var boardPosition : Int = 0
    
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        
        if(self.isHighlighted)
        {
            CGContextSetStrokeColorWithColor(ctx, UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0).CGColor)
            CGContextStrokeRectWithWidth(ctx, CGRectInset(rect, 4.0, 4.0), 3.0 )
        }
        
        switch self.type
        {
        case .Circle:
            let outerCircle = CGPathCreateMutable()
            CGPathAddEllipseInRect(outerCircle, nil, CGRectInset(rect, rect.width * 0.1, rect.height * 0.1))
            CGContextAddPath(ctx, outerCircle)
            CGContextSetFillColorWithColor(ctx, elementColor.CGColor)
            CGContextFillPath(ctx)
            
            let innerCircle = CGPathCreateMutable()
            CGPathAddEllipseInRect(innerCircle, nil, CGRectInset(rect, rect.width * 0.2, rect.height * 0.2))
            CGContextAddPath(ctx, innerCircle)
            CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
            
            CGContextFillPath(ctx)
        case .Cross:
            let path = CGPathCreateMutable()
            let d : CGFloat = 0.1
            let r = CGRectInset(rect, rect.width * 0.1, rect.height * 0.1)
            var m = CGAffineTransformMakeTranslation(rect.width * 0.1, rect.height * 0.1)
            CGPathMoveToPoint(path, &m, r.width * d, 0)
            CGPathAddLineToPoint(path, &m, 0, r.height * d)
            CGPathAddLineToPoint(path, &m, r.width * (1-d), r.height)
            CGPathAddLineToPoint(path, &m, r.width, r.height * (1-d))
            CGPathCloseSubpath(path)
            CGPathMoveToPoint(path, &m, r.width * (1-d), 0)
            CGPathAddLineToPoint(path, &m, 0, r.height * (1-d))
            CGPathAddLineToPoint(path, &m, r.width * d, r.height)
            CGPathAddLineToPoint(path, &m, r.width, r.height * d)
            CGPathCloseSubpath(path)
            
            CGContextAddPath(ctx, path)
            CGContextSetFillColorWithColor(ctx, elementColor.CGColor)
            CGContextFillPath(ctx)
        case .Empty:
            break
        }
    }
    
}
