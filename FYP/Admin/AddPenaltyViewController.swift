//
//  AddPenaltyViewController.swift
//  FYP
//
//  Created by Project  on 10/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log
import CoreData

class AddPenaltyViewController: UIViewController {
    
    var event: EventItem? = nil 
    var fixture: FixtureItem? = nil
    var period: String = ""
    @IBOutlet weak var penaltyNameTxtField: UITextField!
    @IBOutlet weak var playerNameTxtField: UITextField!
    @IBOutlet weak var teamTxtField: UITextField!
    @IBOutlet weak var timeTxtField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var period1Button: UIButton!
    @IBOutlet weak var period2Button: UIButton!
    @IBOutlet weak var period3Button: UIButton!
    
    @IBAction func period1(_ sender: UIButton) {
        period1Button.setBackgroundImage(UIImage(named: "Period1Pressed"), for: .normal)
        period2Button.setBackgroundImage(UIImage(named: "Period2Button"), for: .normal)
        period3Button.setBackgroundImage(UIImage(named: "Period3Button"), for: .normal)
        period = "1"
    }
    @IBAction func period2(_ sender: UIButton) {
        period2Button.setBackgroundImage(UIImage(named: "Period2Pressed"), for: .normal)
        period1Button.setBackgroundImage(UIImage(named: "Period1Button"), for: .normal)
        period3Button.setBackgroundImage(UIImage(named: "Period3Button"), for: .normal)
        period = "2"
        
    }
    @IBAction func period3(_ sender: UIButton) {
        period = "3"
        period3Button.setBackgroundImage(UIImage(named: "Period3Pressed"), for: .normal)
        period1Button.setBackgroundImage(UIImage(named: "Period1Button"), for: .normal)
        period2Button.setBackgroundImage(UIImage(named: "Period2Button"), for: .normal)
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = event {
            penaltyNameTxtField.text = event.name
            playerNameTxtField.text   = event.player
            teamTxtField.text = event.team
            timeTxtField.text = event.time
            switch (event.period) {
            case "1":
                period1Button.setBackgroundImage(UIImage(named: "Period1Pressed"), for: .normal)
            case "2":
                period2Button.setBackgroundImage(UIImage(named: "Period2Pressed"), for: .normal)
                
            case "3":
                period3Button.setBackgroundImage(UIImage(named: "Period3Pressed"), for: .normal)
            default:
                period1Button.setBackgroundImage(UIImage(named: "Period1Button"), for: .normal)
                period2Button.setBackgroundImage(UIImage(named: "Period2Button"), for: .normal)
                
                period3Button.setBackgroundImage(UIImage(named:"Period3Button"), for: .normal)
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let penaltyName = penaltyNameTxtField.text ?? ""
        let playerName = playerNameTxtField.text ?? ""
        let teamName = teamTxtField.text ?? ""
        let time = timeTxtField.text ?? ""
        
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
        
        event = EventItem(id: count, type: "Penalty", name: penaltyName, player: playerName, time: time, period: period, team: teamName, fixtureID: fixture!.id)
    }
}
