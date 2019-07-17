//
//  ViewController.swift
//  Calculator
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Operator {
        case plus
        case minus
        case multi
        case divide
    }
    
    @IBOutlet weak var mButtonZero: UIButton!
    
    @IBOutlet weak var mLabelFirstNum: UILabel!
    @IBOutlet weak var mLabelEquation: UILabel!
    @IBOutlet weak var mLabelSecondNum: UILabel!
    @IBOutlet weak var mLabelResult: UILabel!
    
    
    @IBOutlet weak var mLabel01: UILabel!
    
    var isAfter = false
    var isOver = false
    var mFirstString = ""
    var mSecondString = ""
    
    var mOperator: Operator = Operator.plus
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setNil()
        mLabel01.isHidden = true
        //mButtonZero.layer.cornerRadius = 10
        //mButtonZero.clipsToBounds = true
    }
    
    private func insertChar(char: Character)
    {
        if !isAfter
        {
            mFirstString.append(char)
            mLabelFirstNum.text = mFirstString
        }
        else
        {
            mSecondString.append(char)
            mLabelSecondNum.text = mSecondString
        }
    }
    
    private func setNil()
    {
        mLabelFirstNum.text = nil
        mLabelSecondNum.text = nil
        mLabelEquation.text = nil
        mLabelResult.text = nil
        mFirstString = ""
        mSecondString = ""
    }
    
    private func startOver()
    {
        if isOver {
            setNil()
            isAfter = false
            isOver = false
        }
   }
    
    @IBAction func buttonC(_ sender: UIButton) {
        setNil()
        isAfter = false
    }
    
    @IBAction func buttonNegative(_ sender: UIButton) {
        if isOver {
            return
        }
        
        var mLabel: UILabel!
        var newString: String = ""
        
        if isAfter
        {
            newString = mSecondString
            mLabel = mLabelSecondNum
        }
        else {
            newString = mFirstString
            mLabel = mLabelFirstNum
        }

        if newString.hasPrefix("-")
        {
            newString.remove(at: newString.startIndex)
            mLabel.text = newString
        }
        else
        {
            newString.insert("-", at: newString.startIndex)
            mLabel.text = newString
        }
        
        if isAfter
        {
            mSecondString = newString
        }
        else {
            mFirstString = newString
        }
    }
    
    
    @IBAction func buttonPercent(_ sender: UIButton) {
        if isOver {
            return
        }
        var isNegative = false
        var mLabel: UILabel!
        var newString: String = ""
        if isAfter
        {
            newString = mSecondString
            mLabel = mLabelSecondNum
        } else {
            newString = mFirstString
            mLabel = mLabelFirstNum
        }
        if newString.contains("-") {
            isNegative = true
            let negaIndex = newString.index(of: "-")
            newString.remove(at: negaIndex!)
        }
        if newString.contains(".") {
            let index = newString.index(of: ".")
            newString.remove(at: index!)
            if index == newString.index(after: newString.startIndex) || newString.count == 1 {
                newString = "0." + newString
            }
            else {
                newString.insert(".", at: newString.index(before: index!))
            }
        } else if newString == "" {
            newString = "0.0"
        } else {
            newString.insert(".", at: newString.index(before: newString.endIndex))
        }
        if isNegative {
            newString.insert("-", at: newString.startIndex)
        }
        
        mLabel.text = newString

        if isAfter {
            mSecondString = newString
        }
        else {
            mFirstString = newString
        }
    }
    
    
    @IBAction func buttonPlus(_ sender: UIButton) {
        isAfter = true
        mOperator = .plus
        mLabelEquation.text = "+"
        mLabelResult.text = ""
    }
    
    
    @IBAction func buttonMinus(_ sender: UIButton) {
        isAfter = true
        mOperator = .minus
        mLabelEquation.text = "-"
        mLabelResult.text = ""
    }
    
    @IBAction func buttonMulti(_ sender: UIButton) {
        isAfter = true
        mOperator = .multi
        mLabelEquation.text = "*"
        mLabelResult.text = ""
    }
    
    
    @IBAction func buttonDivide(_ sender: UIButton) {
        isAfter = true
        mOperator = .divide
        mLabelEquation.text = "/"
        mLabelResult.text = ""
    }
    
    private func checkIntAndPrint(_ result: Double)
    {   //result.round(.down)
        if floor(result) == result {
            mLabelResult.text = "\(Int(result))"
        } else {
            mLabelResult.text = "\(result)"
        }
    }
    
    @IBAction func buttonResult(_ sender: UIButton) {
        var firstNumber: Double?
        var secondNumber: Double?
        
        if mFirstString == "-" || mSecondString == "-" {
            return
        }
        
        if mFirstString == "" {
            firstNumber = 0
        } else {
            firstNumber = Double(mFirstString)
        }
        if !isAfter {
            checkIntAndPrint(firstNumber!)
        } else {
            if mSecondString == "" {
                secondNumber = 0
            } else {
                secondNumber = Double(mSecondString)
            }
            switch mOperator {
            case .plus:
                checkIntAndPrint(firstNumber! + secondNumber!)
            case .minus:
                checkIntAndPrint(firstNumber! - secondNumber!)
            case .multi:
                checkIntAndPrint(firstNumber! * secondNumber!)
            case .divide:
                if secondNumber == 0.0 {
                    mLabelResult.text = "Error. Can't divide by 0"
                } else {
                    checkIntAndPrint(firstNumber! / secondNumber!)
                }
            }

        }
        isOver = true
    }
    
    
    
    @IBAction func buttonDot(_ sender: UIButton) {
        if mFirstString.contains(".") {
            return
        }
        if mSecondString.contains(".") {
            return
        }
        
        if mFirstString == "" {
            mFirstString = "0"
        }
        if mSecondString == "" && isAfter == true {
            mSecondString = "0"
        }
        insertChar(char: ".")
    }
    
    
    @IBAction func buttonZero(_ sender: UIButton) {
        startOver()
        insertChar(char: "0")
    }
    
    
    @IBAction func buttonOne(_ sender: UIButton) {
        startOver()
        insertChar(char: "1")
    }
    
    
    @IBAction func buttonTwo(_ sender: UIButton) {
        startOver()
        insertChar(char: "2")
    }
    
    @IBAction func buttonThree(_ sender: UIButton) {
        startOver()
        insertChar(char: "3")
    }

    @IBAction func buttonFour(_ sender: UIButton) {
        startOver()
        insertChar(char: "4")
    }

    @IBAction func buttonFive(_ sender: UIButton) {
        startOver()
        insertChar(char: "5")
    }

    @IBAction func buttonSix(_ sender: UIButton) {
        startOver()
        insertChar(char: "6")
    }

    @IBAction func buttonSeven(_ sender: UIButton) {
        startOver()
        insertChar(char: "7")
    }
    
    @IBAction func buttonEight(_ sender: UIButton) {
        startOver()
        insertChar(char: "8")
    }

    @IBAction func buttonNine(_ sender: UIButton) {
        startOver()
        insertChar(char: "9")
    }
}

