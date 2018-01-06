//
//  UIViewControllerExt.swift
//  goal.we-app
//
//  Created by JJ Nuijten on 20-12-17.
//  Copyright © 2018 JJ Nuijten. All rights reserved.
//

import UIKit

//Eigen transitie dmv een extensie zodat het lijkt op een navigationcontroller
extension UIViewController {
    
    //Laat de viewcontroller zien waarin je het doel moet aanmaken met een animatie vanuit rechts.
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    //Laat het 2e scherm van de viewcontroller zien als je op de next knop drukt
    func presentSecondaryDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        //Dit stuk code zorgt ervoor dat de 'lagen' viewcontrollers niet over elkaar heen gaan. Zonder deze code werkt teruggaan niet bij het laatste doel-aannmaak scherm omdat de 2e view controller 'op' de eerte staat.
        guard let presentedViewController = presentedViewController else {return}
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
            }
    }
    
    //Laat de volgende viewcontroller zien met een animatie vanuit links. Dit is voor de vorige controller
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
}
