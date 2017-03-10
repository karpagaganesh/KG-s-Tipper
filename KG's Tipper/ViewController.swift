import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customTipSlider: UISlider!
    @IBOutlet weak var newBillAmount: CustomTextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipPercentageSegment: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    let defaults = UserDefaults.standard
    let formatter = NumberFormatter()
    let tipPercentages = [0.10, 0.15,0.20,0.25]
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = Double(newBillAmount.text!) ?? 0
        let tipPercentage = tipPercentageSegment.selectedSegmentIndex != Constants.Global.CUSTOM_SEGMENT_INDEX
            ? tipPercentages[tipPercentageSegment.selectedSegmentIndex] : Double(Int(customTipSlider.value))/100
        updateTipAndTotalLabels(bill: bill, tipPercentage: tipPercentage)
    }
    
    @IBAction func customTipSliderChange(_ sender: UISlider) {
        if customTipSlider.value != 0{
            tipPercentageSegment.selectedSegmentIndex = Constants.Global.CUSTOM_SEGMENT_INDEX;
            setTipPercentageSegmentTitle(title: (String(Int(customTipSlider.value))+Constants.Global.SYMBOL_PERCENTAGE), index: Constants.Global.CUSTOM_SEGMENT_INDEX)
        }
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        customTipSlider.value = 0
        if(tipPercentageSegment.selectedSegmentIndex != Constants.Global.CUSTOM_SEGMENT_INDEX){
            setTipPercentageSegmentTitle(title: Constants.Global.CUSTOM_SEGMENT_TITLE, index: Constants.Global.CUSTOM_SEGMENT_INDEX)
        }
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
        calculateTip(self)
    }
    
    private func formatNumberToLocaleCurrency(value: Double) -> String {
        return formatter.string(from: value as NSNumber)!;
    }

    private func getDefaultTipPercentage() -> Int{
        return defaults.integer(forKey: Constants.Global.KEY_DEFAULT_TIP)
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
}
