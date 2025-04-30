//
//  UITextFieldExtension.swift
//  HAPS Teacher App
//
//  Created by Vijay Sharma on 25/08/23.
//

import Foundation
import UIKit

extension UITextField {
    func setDatePickerAsInputViewFor(target:Any, selector:Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 0))
        datePicker.datePickerMode = .date
        datePicker.sizeToFit()
        self.inputView = datePicker
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 40.0))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancel))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
        toolBar.setItems([cancel,flexibleSpace, done], animated: false)
        datePicker.preferredDatePickerStyle = .inline// date picker type
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}
