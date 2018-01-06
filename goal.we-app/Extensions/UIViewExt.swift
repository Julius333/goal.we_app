//
//  UIViewExt.swift
//  goal.we-app
//
//  Created by JJ Nuijten on 21-12-17.
//  Copyright © 2018 JJ Nuijten. All rights reserved.
//

import UIKit

//Extensie voor
extension UIView {
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    //Toetsenbord animatie. De gegevens van de toestenbordanimatie in variabelen zetten voor aanpassing hieronder
    @objc func keyboardWillChange(_ notification: NSNotification) {
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        //Start en eindframe van elkaar af trekken zodat ik weet welke afstand verandert. Hiermee kunnen buttons mee omhoog geschoven worden als de keyboard omhoog komt.
        let deltaY = endingFrame.origin.y - startingFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
            }, completion: nil)
    }
}
