//
//  Functions.swift
//  meuslugares
//
//  Created by Bruno Lemgruber on 26/12/2017.
//  Copyright © 2017 Bruno Lemgruber. All rights reserved.
//
import Foundation
import UIKit

let FirebaseFailedNotification = Notification.Name("FirebaseFailedNotification")

func fatalFirebaseError(_ error: Error){
    print("***Fatal error: \(error)")
    NotificationCenter.default.post(name: FirebaseFailedNotification, object: nil)
}

// MARK: Dialogs and Alert

func showAlert(view:UIViewController, title:String, message:String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alert.addAction(action)
    view.present(alert,animated: true, completion: nil)
}

func showDialog(view:UIViewController, title:String){
    let alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    loadingIndicator.startAnimating();
    
    alert.view.addSubview(loadingIndicator)
    view.present(alert, animated: true, completion: nil)
}

func dismissDialog(view:UIViewController){
    view.dismiss(animated: false, completion: nil)
}

// MARK: Format Number
//https://stackoverflow.com/questions/32364055/formattting-phone-number-in-swift
func format(phoneNumber sourcePhoneNumber: String) -> String? {
    // Remove any character that is not a number
    let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let length = numbersOnly.count
    let hasLeadingOne = numbersOnly.hasPrefix("1")
    
    // Check for supported phone number length
    guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
        return nil
    }
    
    let hasAreaCode = (length >= 10)
    var sourceIndex = 0
    
    // Leading 1
    var leadingOne = ""
    if hasLeadingOne {
        leadingOne = "1 "
        sourceIndex += 1
    }
    
    // Area code
    var areaCode = ""
    if hasAreaCode {
        let areaCodeLength = 3
        guard let areaCodeSubstring = numbersOnly.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
            return nil
        }
        areaCode = String(format: "(%@) ", areaCodeSubstring)
        sourceIndex += areaCodeLength
    }
    
    // Prefix, 3 characters
    let prefixLength = 3
    guard let prefix = numbersOnly.substring(start: sourceIndex, offsetBy: prefixLength) else {
        return nil
    }
    sourceIndex += prefixLength
    
    // Suffix, 4 characters
    let suffixLength = 4
    guard let suffix = numbersOnly.substring(start: sourceIndex, offsetBy: suffixLength) else {
        return nil
    }
    
    return leadingOne + areaCode + prefix + "-" + suffix
}

extension String {
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
