//
//  ViewController.swift
//  KG's Tipper
//
//  Created by Patchirajan, Karpaga Ganesh on 3/8/17.
//  Copyright © 2017 Patchirajan, Karpaga Ganesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipPercentageSegment: UISegmentedControl!
    @IBOutlet weak var newBillAmount: CustomTextField!
    @IBOutlet weak var customTipSlider: UISlider!

    
    let defaults = UserDefaults.standard
    let tipPercentages = [0.10, 0.15,0.20,0.25]
     
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultTipPercentageSegment = defaults.integer(forKey: "defaultTip")
        tipPercentageSegment.selectedSegmentIndex = defaultTipPercentageSegment
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newBillAmount.becomeFirstResponder()
        let defaultTipPercentageSegment = defaults.integer(forKey: "defaultTip")
        tipPercentageSegment.selectedSegmentIndex = defaultTipPercentageSegment
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func customTipSliderChange(_ sender: UISlider) {
        if customTipSlider.value != 0{
            tipPercentageSegment.selectedSegmentIndex = 4;
            tipPercentageSegment.setTitle((String(Int(customTipSlider.value))+"%"), forSegmentAt: 4)
        }
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        customTipSlider.value = 0
        if(tipPercentageSegment.selectedSegmentIndex != 4){
            tipPercentageSegment.setTitle("Custom", forSegmentAt: 4)
        }
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = Double(newBillAmount.text!) ?? 0
        let tipPercentage = tipPercentageSegment.selectedSegmentIndex != 4 ? tipPercentages[tipPercentageSegment.selectedSegmentIndex] : Double(customTipSlider.value) / 100
        
        let tip = bill * tipPercentage
        let total = bill + tip
        
        tipLabel.text = String(format: "$%0.2f", tip)
        totalLabel.text = String(format: "$%0.2f", total)
    }
}
