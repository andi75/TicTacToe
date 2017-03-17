//
//  ViewController.swift
//  TicTacToe
//
//  Created by Andreas Umbach on 09.08.2015.
//  Copyright (c) 2015 Andreas Umbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBInspectable var circleColor = UIColor.red
    @IBInspectable var crossColor = UIColor.blue
    
    var isCircleTurn = true
    var canMove = true
    var moveCount = 0
    
    var board : [TickTackView?] = [TickTackView?](repeating: nil, count: 10)
    
    @IBOutlet var ticTacViewCollection: [TickTackView]!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        reset()
        
        for ttv in ticTacViewCollection
        {
            board[ ttv.boardPosition ] = ttv as TickTackView?
            print("\(ttv.boardPosition) => \(ttv)")
            let tapReg = UITapGestureRecognizer(target: self, action: #selector(ViewController.tickTackViewTapped(_:)))
            ttv.addGestureRecognizer(tapReg)
        }
    }
    
    func checkForWin() -> TickTackType
    {
        let winrows = [
            [ 1, 2, 3], [4, 5, 6], [7, 8, 9],
            [ 1, 4, 7], [2, 5, 8], [3, 6, 9],
            [ 1, 5, 9], [3, 5, 7]
        ]
        
        var winner = TickTackType.empty
        
        for row in winrows
        {
            if(
                board[ row[0] ]?.type != TickTackType.empty &&
                board[ row[0] ]?.type == board[ row[1] ]?.type &&
                board[ row[0] ]?.type == board[ row[2] ]?.type
            )
            {
                board[ row[0] ]?.isHighlighted = true
                board[ row[1] ]?.isHighlighted = true
                board[ row[2] ]?.isHighlighted = true
                
                winner = board[ row[0] ]!.type
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
        resultLabel.isHidden = true
        canMove = true
        moveCount = 0
    }

    @IBAction func clearPressed() {
        reset()
    }
    
    func tickTackViewTapped(_ sender: UITapGestureRecognizer)
    {
        if(sender.state != .ended || !canMove)
        {
            return
        }
        
        let ttV = sender.view as? TickTackView
        if(ttV != nil && ttV!.type == TickTackType.empty)
        {
            if(self.isCircleTurn)
            {
                ttV!.type = TickTackType.circle
                ttV!.elementColor = circleColor
            }
            else
            {
                ttV!.type = TickTackType.cross
                ttV!.elementColor = crossColor
            }
            isCircleTurn = !isCircleTurn
        }
        moveCount += 1

        let result = checkForWin()
        switch result
        {
        case TickTackType.circle:
            resultLabel.text = "Circle Wins!"
            resultLabel.isHidden = false
            canMove = false
        case TickTackType.cross:
            resultLabel.text = "Cross Wins!"
            resultLabel.isHidden = false
            canMove = false
        default:
            if(moveCount == 9)
            {
                resultLabel.text = "It's a Draw!"
                resultLabel.isHidden = false
                canMove = false
            }
        }
    }
}

