//
//  UIButtonExt.swift
//  goal.we-app
//
//  Created by JJ Nuijten on 28-12-17.
//  Copyright © 2018 JJ Nuijten. All rights reserved.
//

import UIKit


//Kleurselectie van de knoppen SOLO en TOGETHER in een aparte extensie. Houd de code clean
extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.6823529412, blue: 0.5882352941, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.8196078431, blue: 0.7647058824, alpha: 1)
    }
}
