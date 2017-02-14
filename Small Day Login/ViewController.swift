//
//  ViewController.swift
//  Small Day Login
//
//  Created by Ashish Sharma on 2/6/17.
//  Copyright © 2017 Ashish All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var enteredUserName: UITextField!
    @IBOutlet weak var enteredPassword: UITextField!
    
    @IBAction func signInButtonPressed(_ sender: Any)
    {
        if (enteredUserName.text!.isEmpty || enteredPassword.text!.isEmpty)
        {
            let alert = UIAlertController(title: "Incorrect Data", message: "Please enter User Name and Password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Users")
        
        request.predicate = NSPredicate(format: "username = %@",enteredUserName.text!)
        
        request.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results
                {
                        if ( (result as AnyObject).value(forKey: "username") as? String == enteredUserName.text!)
                            {
                                if ((result as AnyObject).value(forKey: "password") as? String == enteredPassword.text! )
                                    {
                                         let loginObject = storyboard?.instantiateViewController(withIdentifier: "BRTableView") as! BRTableViewController
                                         navigationController?.pushViewController(loginObject, animated: true)

                                } } }
            }
            else
            {
                print("no result found")
            }
        }
        catch
        {
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

