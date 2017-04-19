//
// ViewController.swift
//
//  Created by Per on 3/1/17.
//  Copyright © 2017 Per. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customTipPercentLabel1: UILabel!
    @IBOutlet weak var customTipPercentageSlider: UISlider!
    @IBOutlet weak var customTipPercentLabel2: UILabel!
    @IBOutlet weak var tip15Label: UILabel!
    @IBOutlet weak var total15Label: UILabel!
    @IBOutlet weak var tipCustomLabel: UILabel!
    @IBOutlet weak var totalCustomLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.becomeFirstResponder()
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let inputString = inputTextField.text //get user input
        
        
        let sliderValue =
            NSDecimalNumber(integerLiteral: Int(customTipPercentageSlider.value))
        
        // divide sliderValue by 100.0 to get tip %
        let customPercent = sliderValue / NSDecimalNumber(string: "100.0")
        
        if sender is UISlider {
            customTipPercentLabel1.text =
                NumberFormatter.localizedString(from: customPercent,
                                                number: NumberFormatter.Style.percent)
            customTipPercentLabel2.text = customTipPercentLabel1.text
        }
        
        
        if !(inputString?.isEmpty)! {

            let billAmount =
                NSDecimalNumber(string: inputString)
            
            
            if sender is UITextField {
                
                let fifteenTip = billAmount * NSDecimalNumber(string: "0.15")
                tip15Label.text = formatToCurrency(number: fifteenTip)
                total15Label.text =
                    formatToCurrency(number: billAmount + fifteenTip)
            }
            
            // calculate custom tip
            let customTip = billAmount * customPercent
            tipCustomLabel.text = formatToCurrency(number: customTip)
            totalCustomLabel.text =
                formatToCurrency(number: billAmount + customTip)
        }
        else {// clear all Labels
            tip15Label.text = ""
            total15Label.text = ""
            tipCustomLabel.text = ""
            totalCustomLabel.text = ""
        }
    }
    
}

// convert a numeric value to localized currency string
func formatToCurrency(number: NSNumber) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2;
    formatter.locale = Locale(identifier: Locale.current.identifier)
    let result = formatter.string(from: number as NSNumber);
    return result!;
}
// overloaded operators to support for NSDecimalNumbers calculations

func + (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.adding(right)
}

func * (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.multiplying(by: right)
}

func / (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.dividing(by: right)
}
