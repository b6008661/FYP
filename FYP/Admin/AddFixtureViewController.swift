//
//  AddFixtureViewController.swift
//  FYP
//
//  Created by Project  on 06/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log

class AddFixtureViewController: UIViewController {
    
    var fixture: FixtureItem? = nil
    
    @IBOutlet weak var homeTeamInput: UITextField!
    @IBOutlet weak var awayTeamInput: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    @IBOutlet weak var timeInput: UITextField!
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
        
        let homeTeam = homeTeamInput.text ?? ""
        let awayTeam = awayTeamInput.text ?? ""
        let date = dateInput.text ?? ""
        let time = timeInput.text ?? ""
        
        fixture = FixtureItem(homeTeam: homeTeam, awayTeam: awayTeam, date: date, time: time)
    }

}
