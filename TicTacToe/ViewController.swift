//
//  ViewController.swift
//  TicTacToe
//
//  Created by Andreas Umbach on 09.08.2015.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBInspectable var circleColor = UIColor.redColor()
    @IBInspectable var crossColor = UIColor.blueColor()
    
    var isCircleTurn = true
    
    @IBOutlet var ticTacViewCollection: [TickTackView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        for ttv in ticTacViewCollection
        {
            ttv.type = TickTackType.Empty
            let tapReg = UITapGestureRecognizer(target: self, action: Selector("tickTackViewTapped:"))
            ttv.addGestureRecognizer(tapReg)
//            println("user interaction: \(ttv.userInteractionEnabled)")
        }
    }

    @IBAction func clearPressed() {
        for ttv in ticTacViewCollection
        {
            ttv.type = TickTackType.Empty
        }
    }
    
    func tickTackViewTapped(sender: UITapGestureRecognizer)
    {
        if(sender.state != .Ended)
        {
            return
        }
        
        let ttV = sender.view as? TickTackView
        if(ttV != nil && ttV!.type == TickTackType.Empty)
        {
            if(self.isCircleTurn)
            {
                ttV!.type = TickTackType.Circle
                ttV!.elementColor = circleColor
            }
            else
            {
                ttV!.type = TickTackType.Cross
                ttV!.elementColor = crossColor
            }
            isCircleTurn = !isCircleTurn
        }
    }
}

