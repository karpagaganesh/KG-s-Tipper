//
//  SettingsViewController.swift
//  KG's Tipper
//
//  Created by Patchirajan, Karpaga Ganesh on 3/8/17.
//  Copyright © 2017 Patchirajan, Karpaga Ganesh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTip: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultTip.selectedSegmentIndex = defaults.integer(forKey: "defaultTip")
    }
    
    @IBAction func updateDefaultTipPercentage(_ sender: UISegmentedControl) {
        defaults.set(defaultTip.selectedSegmentIndex, forKey: "defaultTip")
    }
}
