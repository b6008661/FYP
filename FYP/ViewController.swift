//
//  ViewController.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //////MARK: Properties//////
    var users: [UserItem] = []
    var user: UserItem?
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    //////Mark: Methods//////
    @IBAction func login(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if usernameTxtField.text == data.value(forKey: "email") as? String
                {
                    if passwordTxtField.text == data.value(forKey: "password") as? String
                    {
                        
                        let email = data.value(forKey: "email") as? String
                        let password = data.value(forKey: "password") as? String
                        let id = data.value(forKey: "id") as? String
                        let name = data.value(forKey: "name") as? String
                        
                        user = UserItem(email: email!, password: password!, name: name!, id: id!)
                        performSegue(withIdentifier: "Login", sender: self)
                    }
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    //////MARK: On Load //////
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue("claire@hotmail.com", forKey: "email")
        newUser.setValue("Hello1234", forKey: "password")
        newUser.setValue("Claire Smith", forKey: "name")
        newUser.setValue("1", forKey: "id")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    /////// MARK: - Navigation//////
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "Login" {
            let destinationNavigationController = segue.destination as! UINavigationController
            //        let targetController = destinationNavigationController.topViewController
            let targetController = destinationNavigationController.topViewController as! HomeTableViewController
            targetController.currentUser = user
        }
        
    }

}

