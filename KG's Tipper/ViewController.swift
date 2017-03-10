import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipPercentageSegment: UISegmentedControl!
    @IBOutlet weak var newBillAmount: CustomTextField!
    @IBOutlet weak var customTipSlider: UISlider!

    let defaults = UserDefaults.standard
    let formatter = NumberFormatter()
    let tipPercentages = [0.10, 0.15,0.20,0.25]
    
    let CUSTOM_SEGMENT_INDEX = 4
    let CUSTOM_SEGMENT_TITLE = "Custom"
    let KEY_DEFAULT_TIP = "defaultTip"
    let SYMBOL_PERCENTAGE = "%"
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func customTipSliderChange(_ sender: UISlider) {
        if customTipSlider.value != 0{
            tipPercentageSegment.selectedSegmentIndex = CUSTOM_SEGMENT_INDEX;
            setTipPercentageSegmentTitle(title: (String(Int(customTipSlider.value))+SYMBOL_PERCENTAGE), index: CUSTOM_SEGMENT_INDEX)
        }
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        customTipSlider.value = 0
        if(tipPercentageSegment.selectedSegmentIndex != CUSTOM_SEGMENT_INDEX){
            setTipPercentageSegmentTitle(title: CUSTOM_SEGMENT_TITLE, index: CUSTOM_SEGMENT_INDEX)
        }
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = Double(newBillAmount.text!) ?? 0
        let tipPercentage = tipPercentageSegment.selectedSegmentIndex != CUSTOM_SEGMENT_INDEX ? tipPercentages[tipPercentageSegment.selectedSegmentIndex] : Double(Int(customTipSlider.value))/100
        updateTipAndTotalLabels(bill: bill, tipPercentage: tipPercentage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.adjustsFontSizeToFitWidth = true;
        totalLabel.adjustsFontSizeToFitWidth = true;
        newBillAmount.adjustsFontSizeToFitWidth = true;
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2;
        formatter.locale = Locale(identifier: Locale.current.identifier)
        tipPercentageSegment.selectedSegmentIndex = getDefaultTipPercentage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newBillAmount.becomeFirstResponder()
        tipPercentageSegment.selectedSegmentIndex = getDefaultTipPercentage()
    }

    private func getDefaultTipPercentage() -> Int{
        return defaults.integer(forKey: KEY_DEFAULT_TIP)
    }
    
    private func setTipPercentageSegmentTitle(title: String, index: Int){
        tipPercentageSegment.setTitle(title, forSegmentAt: index)
    }
    
    private func updateTipAndTotalLabels(bill: Double, tipPercentage: Double ){
        let tip = bill * tipPercentage
        let total = bill + tip
        tipLabel.text = formatNumberToLocaleCurrency(value: tip)
        totalLabel.text = formatNumberToLocaleCurrency(value: total)
    }
    
    private func formatNumberToLocaleCurrency(value: Double) -> String {
        return formatter.string(from: value as NSNumber)!;
    }
}
