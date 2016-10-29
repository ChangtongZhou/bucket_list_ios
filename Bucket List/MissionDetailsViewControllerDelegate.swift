//
//  MissionDetailsViewControllerDelegate.swift
//  Bucket List
//
//  Created by Changtong Zhou on 7/14/16.
//  Copyright © 2016 Changtong Zhou. All rights reserved.
//

import UIKit

protocol MissionDetailsViewControllerDelegate: class{
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String)
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: Mission)
    
//    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: String, atIndexPath indexPath: Int)
    

}
