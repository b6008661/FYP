//
//  AddPenaltyViewController.swift
//  FYP
//
//  Created by Project  on 10/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log

class AddPenaltyViewController: UIViewController {
    
    var event: EventItem? = nil 
    
    @IBOutlet weak var penaltyNameTxtField: UITextField!
    @IBOutlet weak var playerNameTxtField: UITextField!
    @IBOutlet weak var teamTxtField: UITextField!
    @IBOutlet weak var timeTxtField: UITextField!
    @IBOutlet weak var periodTxtField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let period = periodTxtField.text ?? ""
        
        event = EventItem(type: "Penalty", name: penaltyName, player: playerName, time: time, period: period, team: teamName)
    }
}
