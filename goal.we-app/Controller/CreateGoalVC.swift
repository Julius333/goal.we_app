//
//  CreateGoalVC.swift
//  goal.we-app
//
//  Created by JJ Nuijten on 14-12-17.
//  Copyright © 2018 JJ Nuijten. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var soloBtn: UIButton!
    @IBOutlet weak var togetherBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    //De standaardweergave
    var goalType: GoalType = .solo
    
    //Weergave opties bij laden.
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        soloBtn.setSelectedColor()
        togetherBtn.setDeselectedColor()
        goalTextView.delegate = self
    }
    
    //Selectie verandert naar together samen met kleur (aan de hand van de extensie)
    @IBAction func togetherBtnWasPressed(_ sender: Any) {
        goalType = .together
        togetherBtn.setSelectedColor()
        soloBtn.setDeselectedColor()
    }
    
    //Selectie verandert naar solo samen met kleur (aan de hand van de extensie)
    @IBAction func soloBtnWasPressed(_ sender: Any) {
        goalType = .solo
        soloBtn.setSelectedColor()
        togetherBtn.setDeselectedColor()
    }
    
    //De knop indrukken laat de laatste viewcontroller zien waarin je je een doel aanmaakt.
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else { return }
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    //Terug naar hoofd viewcontroller
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    //Wanneer je de textview begint te editen, verwijdert de placeholder en word de tekstkleur donkerder.
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
}
