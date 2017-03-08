//
//  ViewController.swift
//  Gotta Tip
//
//  Created by Patchirajan, Karpaga Ganesh on 3/6/17.
//  Copyright © 2017 Patchirajan, Karpaga Ganesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipPercentageSegment: UISegmentedControl!
    @IBOutlet weak var newBillAmount: UITextField!
    @IBOutlet weak var customTipSlider: UISlider!
    
    let defaults = UserDefaults.standard
    let tipPercentages = [0.10, 0.15,0.20,0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultTipPercentageSegment = defaults.integer(forKey: "defaultTip")
        tipPercentageSegment.selectedSegmentIndex = defaultTipPercentageSegment
        tipPercentageSegment.tag = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newBillAmount.becomeFirstResponder()
        let defaultTipPercentageSegment = defaults.integer(forKey: "defaultTip")
        tipPercentageSegment.selectedSegmentIndex = defaultTipPercentageSegment
    }
    
    @IBAction func customTipSliderChange(_ sender: UISlider) {
        if customTipSlider.value != 0{
            tipPercentageSegment.selectedSegmentIndex = 4;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        customTipSlider.value = 0
        if(tipPercentageSegment.selectedSegmentIndex != 4){
            tipPercentageSegment.setTitle("Custom", forSegmentAt: 4)
        }
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = Double(newBillAmount.text!) ?? 0
        
        var tipPercentage = 0.0
        if(tipPercentageSegment.selectedSegmentIndex != 4){
            tipPercentage = tipPercentages[tipPercentageSegment.selectedSegmentIndex]
        }
        else{
            tipPercentage = Double(customTipSlider.value) / 100
            tipPercentageSegment.setTitle((String(format:"%0.2f",customTipSlider.value)+"%"), forSegmentAt: 4)
        }
        let tip = bill * tipPercentage
        let total = bill + tip
        
        tipLabel.text = String(format: "$%0.2f", tip)
        totalLabel.text = String(format: "$%0.2f", total)
    }
}
