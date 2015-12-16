//
//  ViewController.swift
//  retro-calculator
//
//  Created by Gabriel Del VIllar on 12/14/15.
//  Copyright © 2015 gdelvillar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
    
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    @IBOutlet weak var outputLbl: UILabel!
    
    
    var btnSound: AVAudioPlayer!                      // reference to audio
    var runningNumber = ""                            // curent calculated number
    var leftValStr = ""                               // 1st operand
    var rightValStr = ""                              // 2nd operand
    var currentOperation: Operation = Operation.Empty // holds previously pressed operator
    var result = ""                                   // holds the result of the calculation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //audio file's path
        let path =
        NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            // retreiving audio file
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
            
            // print error if the file could not be accessed
        }catch let err as NSError{
            print(err.debugDescription)
            
        }
        
    }
    
    // when number button is pressed
    @IBAction func numberPressed (btn: UIButton!){
        playSound()
        
        // update the Label to the number pressed
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    
    }

    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(currentOperation)
        clearCalculator()
        

        
    }
    
    @IBAction func clearPressed(sender: UIButton) {
        playSound()
        clearCalculator()
        outputLbl.text = "0"
        
    }
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            
            // A user selected an operator, but then seleceted another opereator
            // without selecting another number
            if runningNumber != ""{
                
                // run some math
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            
            }
            
            
            currentOperation = op
            
            
            
        }else{
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        
        
        }
    
    }
    
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func clearCalculator(){
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        
    }
    
}

