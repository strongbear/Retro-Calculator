//
//  ViewController.swift
//  retroCalculator
//
//  Created by Casey Lyman on 1/17/16.
//  Copyright © 2016 bearcode. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Multiply = "*"
        case Divide = "/"
        case Add = "+"
        case Subtract = "-"
        case Empty = ""
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    var runningNumber = ""
    var leftNumStr = ""
    var rightNumStr = ""
    var result = 0.0
    var resultStr = ""
    var currentOperation: Operation!
    
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        currentOperation = Operation.Empty
        outputLbl.text = "0"
    }

    @IBAction func buttonPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        performOperation(Operation.Multiply)
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        performOperation(Operation.Divide)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        performOperation(Operation.Add)
    }
       
    @IBAction func onSubtractPressed(sender: AnyObject) {
        performOperation(Operation.Subtract)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        performOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject){
        clearStack()
    }
    
    func performOperation(op:Operation){
        playSound()
        if runningNumber != ""{
            if currentOperation != Operation.Empty && leftNumStr != ""{
                rightNumStr = runningNumber
                if currentOperation == Operation.Multiply{
                    resultStr = "\(Double(leftNumStr)! * Double(rightNumStr)!)"
                    result = Double(leftNumStr)! * Double(rightNumStr)!
                }else if currentOperation == Operation.Divide{
                    resultStr = "\(Double(leftNumStr)! / Double(rightNumStr)!)"
                    result = Double(leftNumStr)! / Double(rightNumStr)!
                }else if currentOperation == Operation.Add{
                    resultStr = "\(Double(leftNumStr)! + Double(rightNumStr)!)"
                    result = Double(leftNumStr)! + Double(rightNumStr)!
                }else if currentOperation == Operation.Subtract{
                    resultStr = "\(Double(leftNumStr)! - Double(rightNumStr)!)"
                    result = Double(leftNumStr)! - Double(rightNumStr)!
                }
                updateStack()
                outputLbl.text = String.localizedStringWithFormat("%.3f", result)
                
            }else{
                resultStr = runningNumber
                updateStack()
            }

        }
        
        currentOperation = op
    }
    func clearStack(){
        leftNumStr = ""
        rightNumStr = ""
        runningNumber = ""
        resultStr = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
    }
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    func updateStack(){
        leftNumStr = resultStr
        runningNumber = ""
    }
    
}

