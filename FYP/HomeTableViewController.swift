//
//  HomeTableViewController.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData



class HomeTableViewController: UITableViewController {

    var fixtures: [FixtureItem] = []
    
    
    private func loadFixtures() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Fixture", in: context)
        let newFixture = NSManagedObject(entity: entity!, insertInto: context)
        newFixture.setValue("Nottingham Panthers", forKey: "homeTeam")
        newFixture.setValue("Sheffield Steelers", forKey: "awayTeam")
        newFixture.setValue("26/12/2018", forKey: "date")
        newFixture.setValue("17:00", forKey: "time")
        let newFixture2 = NSManagedObject(entity: entity!, insertInto: context)
        newFixture2.setValue("Sheffield Steelers", forKey: "homeTeam")
        newFixture2.setValue("Nottingham Panthers", forKey: "awayTeam")
        newFixture2.setValue("27/12/2018", forKey: "date")
        newFixture2.setValue("19:00", forKey: "time")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFixtures()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Fixture")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let fixture = FixtureItem(homeTeam: data.value(forKey: "homeTeam") as! String, awayTeam: data.value(forKey: "awayTeam") as! String, date: data.value(forKey: "date") as! String, time: data.value(forKey: "time") as! String)
                print(data.value(forKey: "homeTeam") as! String)
                fixtures += [fixture]
            }
            
        } catch {
            
            print("Failed")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fixtures.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureTableViewCell", for: indexPath) as? FixtureTableViewCell else {
            fatalError()
        }
        
        let fixture = fixtures[indexPath.row]
        print(fixture.homeTeam)
        print(fixture.date)

        cell.homeTeam.image = UIImage(named: fixture.homeTeam)
        cell.awayTeam.image = UIImage(named: fixture.awayTeam)
        cell.dateLbl.text = fixture.date
        cell.timeLbl.text = fixture.time

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
