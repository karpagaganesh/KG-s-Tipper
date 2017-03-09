//
//  CustomTextField.swift
//  KG's Tipper
//
//  Created by Patchirajan, Karpaga Ganesh on 3/8/17.
//  Copyright © 2017 Patchirajan, Karpaga Ganesh. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action != #selector(paste(_:))
    }
}
