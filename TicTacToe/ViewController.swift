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
    
    var board : [TickTackView?] = [TickTackView?](count: 10, repeatedValue: nil)
    
    @IBOutlet var ticTacViewCollection: [TickTackView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        reset()
        
        for ttv in ticTacViewCollection
        {
            board[ ttv.boardPosition ] = ttv as TickTackView?
            println("\(ttv.boardPosition) => \(ttv)")
            let tapReg = UITapGestureRecognizer(target: self, action: Selector("tickTackViewTapped:"))
            ttv.addGestureRecognizer(tapReg)
        }
    }
    
    func checkForWin() -> TickTackType?
    {
        let winrows = [
            [ 1, 2, 3], [4, 5, 6], [7, 8, 9],
            [ 1, 4, 7], [2, 5, 8], [3, 6, 9],
            [ 1, 5, 9], [3, 5, 7]
        ]
        
        var winner : TickTackType? = nil
        
        for row in winrows
        {
            if(
                board[ row[0] ]?.type != TickTackType.Empty &&
                board[ row[0] ]?.type == board[ row[1] ]?.type &&
                board[ row[0] ]?.type == board[ row[2] ]?.type
            )
            {
                board[ row[0] ]?.isHighlighted = true
                board[ row[1] ]?.isHighlighted = true
                board[ row[2] ]?.isHighlighted = true
                
                winner = board[ row[0] ]?.type
            }
        }
        return winner
    }
    
    func reset()
    {
        for ttv in ticTacViewCollection
        {
            ttv.reset()
        }
    }

    @IBAction func clearPressed() {
        reset()
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
        
        checkForWin()
    }
}

