//
//  MissionDetailsViewController.swift
//  Bucket List
//
//  Created by Changtong Zhou on 7/13/16.
//  Copyright © 2016 Changtong Zhou. All rights reserved.
//

import CoreData
import UIKit
class MissionDetailsViewController: UITableViewController{
    

    var missionToEdit: Mission?
    
//    var missionToEditIndexPath: Int?
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    
    weak var delegate: MissionDetailsViewControllerDelegate?
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mission_to_edit = missionToEdit{
            newMissionTextField.text = mission_to_edit.details
        }
    }
    
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }

    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        if let missionEdit = missionToEdit{
            missionEdit.details = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishEditingMission: missionEdit)
            
        }else{
            let mission = newMissionTextField.text!

            delegate?.missionDetailsViewController(self, didFinishAddingMission: mission)
            
        }
        
    }
    
    @IBOutlet weak var newMissionTextField: UITextField!
    

    
}
