//
//  UILabelView+Extension.swift
//  WordsFactory
//
//  Created by Алёна Максимова on 20.07.2023.
//

import UIKit

extension UILabel {
    func partTextColorChange (fullText : String, changeText : String) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "PrimaryColor") ?? .black , range: range)
        self.attributedText = attribute
    }
}
