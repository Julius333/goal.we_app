//
//  GoalCell.swift
//  goal.we-app
//
//  Created by JJ Nuijten on 23-12-17.
//  Copyright © 2018 JJ Nuijten. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    //Hier worden alle variabelen met Core Data in de correcte plaats in de Cell gezet.
    func configureCell(goal: Goal) {
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        
        //De completionView is het beeld dat laat zien dat je doel behaald is. Wanneer die gelijk is aan je gestelde doel word de isHidden false en word hij dus zichtbaar over de cell.
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
        
    }
}
