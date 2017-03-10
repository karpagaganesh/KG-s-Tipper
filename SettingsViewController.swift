import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTip: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultTip.selectedSegmentIndex = defaults.integer(forKey: Constants.Global.KEY_DEFAULT_TIP)
    }
    
    @IBAction func updateDefaultTipPercentage(_ sender: UISegmentedControl) {
        defaults.set(defaultTip.selectedSegmentIndex, forKey: Constants.Global.KEY_DEFAULT_TIP)
    }
}
