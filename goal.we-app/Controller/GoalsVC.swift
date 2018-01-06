//
//  GoalsVC.swift
//  goal.we-app
//
//  Created by JJ Nuijten on 08-12-17.
//  Copyright © 2018 JJ Nuijten. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    //Wanneer de view verschijnt word de functie fetchCoreDataObjects aangeroepen en de tableview word herlaad. Zo blijf je aanpassingen zien.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()

    }
    
    //Wanner er 1 of meer gegevens in de table staan word de tableview weergegeven.
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }

    //Knop indrukken laad animatie in vanuit de extensie
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return }
        presentDetail(createGoalVC)
    }
    
}

//Cellen tonen met de ingevulde gegevens
extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //De hoeveelheid rows worden weergegeven afhankelijk van de hoeveelheid die er in de goals array zijn
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {
            return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    //Het weergeven van de verwijder knop en 'add' knop.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //delete knop
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        //Add knop
        let addAction = UITableViewRowAction(style: .normal, title: "ADD ONE") { (rowAction, indexPath) in
            self.setProgress(atIndexPatch: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return [deleteAction, addAction]
    }
}

extension GoalsVC {
    //Hiermee word je progressie gemeten. Je moet een gegeven aantal opgeven en die word vergeleken met het aantal waar je momenteel op zit.
    func setProgress(atIndexPatch indexpatch: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexpatch.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Verwijdert eeuuujjj!!")
        } catch {
            debugPrint("Helaas: \(error.localizedDescription)")
        }
    }
    
    //De daadwerkelijke functie die word aangeroepen om alles te verwijderen.
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("verwijdertjesss")
        } catch {
            debugPrint("helaas pindacheesee \(error.localizedDescription)")
        }
    }
    
    //Ophalen gegevens uit de entiteit Goal (dit is soort van de offline database, oftewel Core Data)
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("Successful!!!!!")
            completion(true)
        }
        catch {
            debugPrint("Fetch lukt niet: \(error.localizedDescription)")
            completion(false)
        }
    }
}



















