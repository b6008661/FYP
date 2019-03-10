//
//  AdminFixtureViewController.swift
//  FYP
//
//  Created by Project  on 06/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class AdminFixtureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events: [EventItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeTeam: UIImageView!
    @IBOutlet weak var awayTeam: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    @IBAction func start(_ sender: UIButton) {
        addEventButton.isEnabled = true
        finishButton.isEnabled = true
        startButton.isEnabled = false
    }
    
    var fixture: FixtureItem? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let fixture = fixture {
            homeTeam.image = UIImage(named: fixture.homeTeam)
            awayTeam.image = UIImage(named: fixture.awayTeam)
            dateLbl.text = fixture.date
            timelbl.text = fixture.time
        }
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else {
            fatalError()
        }
        
        let event = events[indexPath.row]
        
        cell.eventLbl?.text = event.name
        
        return cell
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
