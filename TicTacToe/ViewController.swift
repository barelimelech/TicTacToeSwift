//
//  ViewController.swift
//  TicTacToe
//
//  Created by CallumHill on 30/7/21.
//

import UIKit

class ViewController: UIViewController
{
	enum Turn {
		case Nought
		case Cross
	}
    
    
    @IBOutlet weak var xScore: UILabel!
    @IBOutlet weak var oScore: UILabel!
    @IBAction func resetBtn(_ sender: UIButton) {
        self.resetBoard()
        won.text = ""
        turnLabel.text = xTurn
        markImg.image = UIImage(named: "empty")
        currentTurn = Turn.Cross

    }
    @IBAction func newGame(_ sender: UIButton) {
        self.resetBoard()
        won.text = ""
        turnLabel.text = xTurn
        markImg.image = UIImage(named: "empty")
        currentTurn = Turn.Cross
        xScore.text = "0"
        oScore.text = "0"
        noughtsScore = 0
        crossesScore = 0
    }
    @IBOutlet weak var won: UILabel!
    @IBOutlet weak var markImg: UIImageView!
    var imageName = ""
    
    @IBOutlet weak var turnLabel: UILabel!
	@IBOutlet weak var a1: UIButton!
	@IBOutlet weak var a2: UIButton!
	@IBOutlet weak var a3: UIButton!
	@IBOutlet weak var b1: UIButton!
	@IBOutlet weak var b2: UIButton!
	@IBOutlet weak var b3: UIButton!
	@IBOutlet weak var c1: UIButton!
	@IBOutlet weak var c2: UIButton!
	@IBOutlet weak var c3: UIButton!
	
	var firstTurn = Turn.Cross
	var currentTurn = Turn.Cross
	
	var NOUGHT = "O"
	var CROSS = "X"
    var oTurn = "O Turn"
    var xTurn = "X Turn"
	var board = [UIButton]()
	
	var noughtsScore = 0
	var crossesScore = 0
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		initBoard()
	}
	
	func initBoard()
	{
		board.append(a1)
		board.append(a2)
		board.append(a3)
		board.append(b1)
		board.append(b2)
		board.append(b3)
		board.append(c1)
		board.append(c2)
		board.append(c3)
	}
    
    func unableButtons(){
        for button in board {
            button.isEnabled = false
        }
    }

	@IBAction func boardTapAction(_ sender: UIButton)
	{
		addToBoard(sender)
		
		if checkForVictory(CROSS)
		{
			crossesScore += 1
			resultAlert(title: "Crosses Win!")
            unableButtons()
		}
		
		else if checkForVictory(NOUGHT)
		{
			noughtsScore += 1
			resultAlert(title: "Noughts Win!")
            unableButtons()
		}
		
		else if(fullBoard())
		{
			resultAlert(title: "Draw")
		}
	}
	
	func checkForVictory(_ s :String) -> Bool
	{
		// Horizontal Victory
		if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
		{
            imageName = "mark6"
			return true
		}
		if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
		{
            imageName = "mark7"
			return true
		}
		if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
		{
            imageName = "mark8"
			return true
		}
		
		// Vertical Victory
		if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
		{
            imageName = "mark3"
			return true
		}
		if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
		{
            imageName = "mark4"
            return true
		}
		if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
		{
            imageName = "mark5"
			return true
		}
		
		// Diagonal Victory
		if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
		{
            imageName = "mark1"
			return true
		}
		if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
		{
            imageName = "mark2"
			return true
		}
		
		return false
	}
	
	func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
	{
		return button.title(for: .normal) == symbol
	}
	
	func resultAlert(title: String)
	{
        if(title != "Draw"){
            xScore.text = String(crossesScore)
            oScore.text = String(noughtsScore)
            markImg.image = UIImage(named: imageName)

            if(title == "Crosses Win!"){
                //won.text = "X Won!"
                turnLabel.text = "X Won!"
            }
            else if(title == "Noughts Win!"){
               // won.text = "O Won!"
                turnLabel.text = "O Won!"

            }
        }
        else{
           // won.text = "No Winner!"
            turnLabel.text = "No Winner!"

        }
	}
	
	func resetBoard()
	{
		for button in board
		{
			button.setTitle(nil, for: .normal)
			button.isEnabled = true
		}
		if firstTurn == Turn.Nought
		{
			firstTurn = Turn.Cross
			turnLabel.text = CROSS
		}
		else if firstTurn == Turn.Cross
		{
			firstTurn = Turn.Nought
			turnLabel.text = NOUGHT
		}
		currentTurn = firstTurn
	}
	
	func fullBoard() -> Bool
	{
		for button in board
		{
			if button.title(for: .normal) == nil
			{
				return false
			}
		}
		return true
	}
	
	func addToBoard(_ sender: UIButton)
	{
		if(sender.title(for: .normal) == nil)
		{
			if(currentTurn == Turn.Nought)
			{
				sender.setTitle(NOUGHT, for: .normal)
				currentTurn = Turn.Cross
				turnLabel.text = xTurn
			}
			else if(currentTurn == Turn.Cross)
			{
				sender.setTitle(CROSS, for: .normal)
				currentTurn = Turn.Nought
				turnLabel.text = oTurn
			}
			sender.isEnabled = false
		}
	}
	
}

