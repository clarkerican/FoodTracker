//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Erica Clark on 6/13/16.
//  Copyright © 2016 Erica Clark. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    
    //MARK: Properties
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem() // adds an edit button
        
        if let savedMeals = loadMeals(){
            meals += savedMeals
        }
        else{
            loadMeals()
        }
        
        //load sample data
        loadSampleMeals()
    }
    
    func loadSampleMeals(){
        let photo1 = UIImage(named: "meal1")!
        let meal1 = Meal(name: "Yum",photo: photo1,rating: 5)!
        
        let photo2 = UIImage(named: "meal2")!
        let meal2 = Meal(name: "Good Food",photo: photo2, rating: 4)!
        
        let photo3 = UIImage(named: "meal3")!
        let meal3 = Meal(name: "More Food", photo: photo3, rating: 5)!
        
        meals += [meal1, meal2, meal3]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int )-> Int{
        return meals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellIdentifier = "MealTableViewCell" // Like the Attribute Identifier of the table view cells
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
        
        cell.mealLabel.text = meal.name
        cell.mealPhoto.image = meal.photo
        cell.mealRating.rating = meal.rating
        
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
           if editingStyle == .Delete {
                    // Delete the row from the data source
                    meals.removeAtIndex(indexPath.row)
                    saveMeals()
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                } else if editingStyle == .Insert {
                    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
                }
        }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }


    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
    
        if segue.identifier == "ShowDetail"{
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            if let selectedMealCell = sender as? MealTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
                
            }
            
        }
        else if segue.identifier == "AddItem"{
            print("Adding new Meal")
        }
    }

    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {

        if let sourceViewController = sender.sourceViewController as? MealViewController,
            meal = sourceViewController.meal{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else{
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)

            }
            saveMeals()

        }
    }
    
    //MARK: NSCoding
    func saveMeals(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save meals")
        }
    }
    
    func loadMeals() -> [Meal]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
    
}
