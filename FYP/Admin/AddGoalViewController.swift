//
//  AddGoalViewController.swift
//  FYP
//
//  Created by Project  on 10/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log

class AddGoalViewController: UIViewController {
    
    var event: EventItem? = nil
    
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

        // Do any additional setup after loading the view.
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
        
        event = EventItem(type: "Goal", name: "", player: playerName, time: time, period: period, team: teamName)
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
