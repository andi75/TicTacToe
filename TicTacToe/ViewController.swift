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

        let tapReg = UITapGestureRecognizer(target: self, action: "tickTackViewTapped:")
        var index: Int = 0
        for view in ticTacViewCollection
        {
            view.type = TickTackType.Empty
            view.addGestureRecognizer(tapReg)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tickTackViewTapped(tappedObj: AnyObject)
    {
        let ttV = tappedObj as? TickTackView
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

