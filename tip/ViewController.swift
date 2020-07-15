//
//  ViewController.swift
//  tip
//
//  Created by Anisha Kabir on 7/13/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let defaults = UserDefaults.standard
    let fmt = NumberFormatter()
    
    var currencySymbol = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // selected option color
        tipControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: "004380".color], for: .selected)

        // color of other options
        tipControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: "57cdfe".color], for: .normal)
        
        currencySymbol = fmt.currencySymbol
        print(currencySymbol)
        billField.placeholder = currencySymbol
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        
        currencySymbol = fmt.currencySymbol
        if billField.text == "" {
            billField.becomeFirstResponder()
        }
        
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTip")
        
        let bill =  Double(billField.text!) ?? 0
        let tipPercentages = [0.15, 0.18, 0.2]
        
        let tip = bill*tipPercentages[defaults.integer(forKey: "defaultTip")]
        let total = bill+tip;
        
        tipLabel.text = currencySymbol + String(format: "%.2f", tip)
        totalLabel.text = currencySymbol + String(format: "%.2f", total)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //print("view will disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did disappear")
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        //get the bill amount
        let bill =  Double(billField.text!) ?? 0
        
        //calculate tip and total
        let tipPercentages = [0.15, 0.18, 0.2]
        
        let tip = bill*tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill+tip;
        
        //update tip and total
        tipLabel.text = currencySymbol + String(format: "%.2f", tip)
        totalLabel.text = currencySymbol + String(format: "%.2f", total)
    }
}

extension String {
    var color: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        if #available(iOS 13, *) {
            //If your string is not a hex colour String then we are returning white color. you can change this to any default colour you want.
            guard let int = Scanner(string: hex).scanInt32(representation: .hexadecimal) else { return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) }

            let a, r, g, b: Int32
            switch hex.count {
            case 3:     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
            case 6:     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
            case 8:     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
            default:    (a, r, g, b) = (255, 0, 0, 0)
            }

            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)

        } else {
            var int = UInt32()

            Scanner(string: hex).scanHexInt32(&int)
            let a, r, g, b: UInt32
            switch hex.count {
            case 3:     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
            case 6:     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
            case 8:     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
            default:    (a, r, g, b) = (255, 0, 0, 0)
            }

            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
        }
    }
}
