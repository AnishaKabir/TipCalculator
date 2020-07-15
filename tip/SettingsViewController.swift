//
//  SettingsViewController.swift
//  tip
//
//  Created by Anisha Kabir on 7/14/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    var initialDefaultSaved = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        defaultTipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTip")
    }
    
    @IBAction func defaultTipChange(_ sender: Any) {
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: "defaultTip")
        defaults.synchronize()
        //print("added to defaults")
        initialDefaultSaved = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
