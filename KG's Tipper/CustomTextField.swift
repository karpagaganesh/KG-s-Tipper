import UIKit

class CustomTextField: UITextField {

    // Disable Paste
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action != #selector(paste(_:))
    }
}
