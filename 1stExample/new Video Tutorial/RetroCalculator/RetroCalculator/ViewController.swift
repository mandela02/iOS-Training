//
//  ViewController.swift
//  RetroCalculator
//
//  Created by mac on 7/12/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var btnSound: AVAudioPlayer!
    
    enum Operator {
        case plus
        case minus
        case multi
        case divide
    }
    
    var result = 0.0
    
    var FirstString = ""
    var SecondString = ""
    
    var isAfter = false
    var isOver = false
    
    var justPressedOperator: Operator = Operator.plus
    var savedOperator: Operator = Operator.plus
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = nil
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
            print("dead")
        }
    }
    
    @IBAction func buttonSoundPressed(sender: UIButton) {
        playSound()
    }
    
    private func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    private func setNil() {
        resultLabel.text = nil
        result = 0.0
        FirstString = ""
        SecondString = ""
        justPressedOperator = .plus
    }
    
    private func startOver()
    {
        if isOver {
            setNil()
            isAfter = false
            isOver = false
        }
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        setNil()
    }
    
    private func insertChar(_ char: Character)
    {
        if !isAfter
        {
            FirstString.append(char)
            resultLabel.text = FirstString
        }
        else
        {
            SecondString.append(char)
            resultLabel.text = SecondString
        }
    }

    
    @IBAction func zeroButtonPressed(_ sender: Any) {
        startOver()
        insertChar("0")
    }
    
    @IBAction func oneButtonPressed(_ sender: Any) {
        startOver()
        insertChar("1")
    }
    
    @IBAction func twoButtonPressed(_ sender: Any) {
        startOver()
        insertChar("2")
    }
    
    @IBAction func threeButtonPressed(_ sender: Any) {
        startOver()
        insertChar("3")
    }
    
    @IBAction func fourButtonPressed(_ sender: Any) {
        startOver()
        insertChar("4")
    }
    
    @IBAction func fiveButtonPressed(_ sender: Any) {
        startOver()
        insertChar("5")
    }
    
    @IBAction func sixButtonPressed(_ sender: Any) {
        startOver()
        insertChar("6")
    }
    
    @IBAction func sevenButtonPressed(_ sender: Any) {
        startOver()
        insertChar("7")
    }
    
    @IBAction func eightButtonPressed(_ sender: Any) {
        startOver()
        insertChar("8")
    }
    
    @IBAction func nineButtonPressed(_ sender: Any) {
        startOver()
        insertChar("9")
    }
    
    private func continueCalculating()
    {
//        FirstString = ""
//        SecondString = ""
//        FirstString = "\(result)"

        if(isOver)
        {
            FirstString = ""
            SecondString = ""
            FirstString = "\(result)"
        }
        isOver = false
    }
    
    @IBAction func divideButtonPressed(_ sender: Any) {
        calculator()
        isAfter = true
        justPressedOperator = .divide
        checkIntAndPrint(result)
    }
    
    @IBAction func multiButtonPressed(_ sender: Any) {
        calculator()
        isAfter = true
        justPressedOperator = .multi
        checkIntAndPrint(result)
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        calculator()
        isAfter = true
        justPressedOperator = .minus
        checkIntAndPrint(result)
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        calculator()
        isAfter = true
        justPressedOperator = .plus
        checkIntAndPrint(result)
    }
    
    private func checkIntAndPrint(_ result: Double)
    {   //result.round(.down)
        if floor(result) == result {
            resultLabel.text = "\(Int(result))"
        } else {
            resultLabel.text = "\(result)"
        }
    }

    
    private func calculator()
    {
        var firstNumber: Double?
        var secondNumber: Double?
        
        if FirstString == "-" || SecondString == "-" {
            return
        }
        
        if FirstString == "" {
            firstNumber = 0
        } else {
            firstNumber = Double(FirstString)
        }
        if !isAfter {
            result = firstNumber!
        } else {
            if SecondString == "" {
                secondNumber = 0
            } else {
                secondNumber = Double(SecondString)
            }
            switch justPressedOperator {
            case .plus:
                result = firstNumber! + secondNumber!
            case .minus:
                result = firstNumber! - secondNumber!
            case .multi:
                result = firstNumber! * secondNumber!
            case .divide:
                if secondNumber == 0.0 {
                    result = 0.0
                    //resultLabel.text = "Error. Can't divide by 0"
                } else {
                    result = firstNumber! / secondNumber!
                }
            }
        }
        FirstString = "\(result)"
        SecondString = ""
        isAfter = false
    }
    
    @IBAction func resultButtonPressed(_ sender: Any) {
        calculator()
        checkIntAndPrint(result)
    }
}

