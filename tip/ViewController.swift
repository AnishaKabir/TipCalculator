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
        tipControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green], for: .selected)

        // color of other options
        tipControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
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
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
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
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

