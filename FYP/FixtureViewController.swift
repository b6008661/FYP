//
//  FixtureViewController.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData
import os.log

class FixtureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var events: [EventItem] = []
    @IBOutlet weak var tableView: UITableView!
    
    private func loadEvents() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
        let newEvent = NSManagedObject(entity: entity!, insertInto: context)
        newEvent.setValue("Penalty", forKey: "type")
        newEvent.setValue("Slashing", forKey: "name")
        newEvent.setValue("Robert Farmer", forKey: "player")
        newEvent.setValue("3:42", forKey: "time")
        newEvent.setValue("1", forKey: "period")
        newEvent.setValue("Nottingham Panthers", forKey: "team")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else {
            fatalError()
        }
        
        let event = events[indexPath.row]
        
       cell.eventLbl.text = event.type
        print(event.type)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadEvents()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let event = EventItem(type: data.value(forKey: "type") as! String, name: data.value(forKey: "name") as! String, player: data.value(forKey: "player") as! String, time: data.value(forKey: "time") as! String, period: data.value(forKey: "period") as! String, team: data.value(forKey: "team") as! String)
                events += [event]
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if ((segue.destination as? EventViewController) != nil) {
        
            guard let eventViewController = segue.destination as? EventViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedEventCell = sender as? EventTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedEvent = events[indexPath.row]
            eventViewController.event = selectedEvent
        }

}

}
