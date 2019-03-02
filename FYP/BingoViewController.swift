//
//  BingoViewController.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class BingoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var gameEvents: [GameEventItem] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    private func loadGameEvents() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "GameEvent", in: context)
        let newGameEvent = NSManagedObject(entity: entity!, insertInto: context)
        newGameEvent.setValue("Robert Farmer", forKey: "player")
        newGameEvent.setValue("Slashing penalty", forKey: "type")
        newGameEvent.setValue("1/2/3", forKey: "period")
        let newGameEvent2 = NSManagedObject(entity: entity!, insertInto: context)
        newGameEvent2.setValue("Steve Lee", forKey: "player")
        newGameEvent2.setValue("Cross check penalty", forKey: "type")
        newGameEvent2.setValue("1/2", forKey: "period")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BingoCollectionViewCell", for: indexPath) as! BingoCollectionViewCell
        
        let gameEvent = gameEvents[indexPath.row]
        
        cell.textArea.text = gameEvent.type + " by " + gameEvent.player + " during period(s) " + gameEvent.period
        
        return cell
        
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        loadGameEvents()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEvent")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let gameEvent = GameEventItem(type: data.value(forKey: "type") as! String, player: data.value(forKey: "player") as! String, period: data.value(forKey: "period") as! String)
                print(gameEvent.type)
                gameEvents += [gameEvent]
            }
            
        } catch {
            
            print("Failed")
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

}
