//
//  AddBingoEventViewController.swift
//  FYP
//
//  Created by Project  on 20/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log
import CoreData

class AddBingoEventViewController: UIViewController {

    //MARK: Properties
    var bingoEvent: BingoEventItem? = nil
    var fixture: FixtureItem? = nil
    @IBOutlet weak var playerTxtField: UITextField!
    @IBOutlet weak var typeTxtField: UITextField!
    @IBOutlet weak var periodTxtField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let playerName = playerTxtField.text ?? ""
        let type = typeTxtField.text ?? ""
        let period = periodTxtField.text ?? ""
        
        var bingoEvents: [NSManagedObject] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BingoEvent")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                bingoEvents += [data]
            }
            
        } catch {
            
            print("Failed")
        }
        
        let count = String(bingoEvents.count + 1)
        
        bingoEvent = BingoEventItem(type: type, player: playerName, period: period, id: count, fixtureID: (fixture?.id)!)
    }
    

}
