//
//  AddGoalViewController.swift
//  FYP
//
//  Created by Project  on 10/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log
import CoreData

class AddGoalViewController: UIViewController {
    
    var event: EventItem? = nil
    var fixture: FixtureItem? = nil
    @IBOutlet weak var playerNameTxtField: UITextField!
    @IBOutlet weak var teamTxtField: UITextField!
    @IBOutlet weak var timeTxtField: UITextField!
    @IBOutlet weak var periodTxtField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let playerName = playerNameTxtField.text ?? ""
        let teamName = teamTxtField.text ?? ""
        let time = timeTxtField.text ?? ""
        let period = periodTxtField.text ?? ""
        
        var events: [NSManagedObject] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                events += [data]
            }
            
        } catch {
            
            print("Failed")
        }
        
        let count = String(events.count + 1)
        
        event = EventItem(id: count, type: "Goal", name: "", player: playerName, time: time, period: period, team: teamName, fixtureID: fixture!.id)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
