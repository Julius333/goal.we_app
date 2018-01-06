//
//  FinishGoalVC.swift
//  goal.we-app
//
//  Created by JJ Nuijten on 16-12-17.
//  Copyright © 2018 JJ Nuijten. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextfield: UITextField!
    
    //Globaal aanmaken van de variabelen waar mijn hele app over gaat!
    var goalDescription: String!
    var goalType: GoalType!
    
    //Het door kunnen geven van de data binnen functies
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextfield.delegate = self
    }

    //Wanneer er iets is ingevuld slaat hij op
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        if pointsTextfield.text != "" {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //Terug vorige viewcontroller
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    //Deze functie slaat de ingevulde gegevens op aan de hand van Core Data
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextfield.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("Succesfully saved data")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
}
















