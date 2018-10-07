//
//  Extensions.swift
//  PLDemo
//
//  Created by Aisha on 7/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


class ModifiedTextField: UITextField {
    override func awakeFromNib() {
        delegate = self
    }
}

extension ModifiedTextField : UITextFieldDelegate{
func textFieldDidBeginEditing(_ textField: UITextField) {
}
    
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    var startString = ""
    if (textField.text != nil)
    {
        startString += textField.text!
    }
    startString += string
    if let limitNumber = getInt(data: startString)
    {
        if limitNumber > kMaxLengthConstant
        {
            return false
        }
        else
        {
            return true;
        }
    }
    else {
        return false
    }
}
    
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
}
}
