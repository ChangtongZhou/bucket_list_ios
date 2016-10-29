//
//  ViewController.swift
//  Bucket List
//
//  Created by Changtong Zhou on 7/13/16.
//  Copyright © 2016 Changtong Zhou. All rights reserved.
//
import CoreData
import UIKit

class BucketListViewController: UITableViewController, CancelButtonDelegate, MissionDetailsViewControllerDelegate {
    
//    var missions = ["Sky diving", "Live in Hawaii"]
    
    var missions = [Mission]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    
    @IBAction func missionPlus(sender: UIBarButtonItem) {
        check = false
        performSegueWithIdentifier("DetailsSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        check = true
        performSegueWithIdentifier("DetailsSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    var check = true{
        didSet{
            print(check)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        check = false
        fetchAllMissions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell")!
        
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.textLabel?.text = missions[indexPath.row].details
        // return cell so that Table View knows what to draw in each row
        
        return cell
    }
    

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
//        missions.removeAtIndex(indexPath.row)
        
        let mission = missions[indexPath.row]
        
        managedObjectContext.deleteObject(mission)
        
        do{
            try managedObjectContext.save()
            
            fetchAllMissions()
            tableView.reloadData()
            
        } catch let error as NSError{
        
            print(error)
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missions.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailsSegue"{
           
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self

            if  check == true{
                if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                    controller.missionToEdit = missions[indexPath.row]
//                    controller.missionToEditIndexPath = indexPath.row
                }
            }
        }
    }
    
    
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String) {
       
//        missions.append(mission)
        
        let entity = NSEntityDescription.entityForName("Mission", inManagedObjectContext: managedObjectContext)
        
        let themission = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        let text = controller.newMissionTextField.text
       
        controller.newMissionTextField.text = ""
        
        print("Text is working or not: ", text)
        
        themission.setValue(text, forKey: "details")
        
        do{
            try managedObjectContext.save()
        } catch let error as NSError{
            
            print(error)
        }
        
        fetchAllMissions()
        
        dismissViewControllerAnimated(true, completion: nil)

        tableView.reloadData()
    }
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: Mission) {
        
        do{
            try managedObjectContext.save()
            
            fetchAllMissions()
            
        } catch let error as NSError{
            
            print(error)
        }
        
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func fetchAllMissions(){
        let fetch = NSFetchRequest(entityName: "Mission")
        
        do{
            let results = try managedObjectContext.executeFetchRequest(fetch)
            missions = results as! [Mission]
        
        }catch let error as NSError{
        
            print (error)
        }
        
    }
    
    
    
}
