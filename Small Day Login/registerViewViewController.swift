//
//  registerViewViewController.swift
//  Small Day Login
//
//  Created by Mahendra L on 2/6/17.
//  Copyright © 2017 Mahendra L. All rights reserved.
//

import UIKit
import CoreData

class registerViewViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource
{

    @IBOutlet weak var enteredUserName: UITextField!
    @IBOutlet weak var enteredFirstName: UITextField!
    @IBOutlet weak var enteredPassword: UITextField!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var dobPicker: UIDatePicker!
    var selectedState = 0
    var userPresentAge = "0"
    let states = ["Hydrabad","Delhi","Pune","Bengaluru","Chennai","Mumbai"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        statePicker.dataSource = self
        statePicker.delegate = self
    }
    
    @IBAction func dateEntered(_ sender: Any)
    {
        let dateVal = sender as! UIDatePicker
        //ageLabel.text = String(describing: dateVal.date)
        let fullNameArr = String(describing: dateVal.date).components(separatedBy: "-")
        let year = Int((fullNameArr[0]))
        //ageLabel.text = String(describing: year!)
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year] , from: date)
        let currentYear = components.year
        if(currentYear! > year!)
        {
            let userAge = String(currentYear! - year!)
            userPresentAge = userAge
        }
        else
        {
            let alert = UIAlertController(title: "Incorrect Input", message: "You can't be born right now or in future. LOL! ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok Sorry!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return states[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return states.count
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedState = row
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: Any)
    {
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue(enteredUserName.text!, forKey: "username")
        newUser.setValue(enteredFirstName.text!, forKey: "firstname")
        newUser.setValue(enteredPassword.text!, forKey: "password")
        newUser.setValue(userPresentAge, forKey: "age")
        newUser.setValue(states[selectedState], forKey: "state")

        do
        {
            try
                context.save()
            
          /*  let loginObject = storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! ViewController
            navigationController?.pushViewController(loginObject, animated: true) */
            
           let alert = UIAlertController(title: "Successfully Added", message: "Your details : \(enteredUserName.text!) , \(enteredFirstName.text!) , \(states[selectedState]) , \(userPresentAge)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Go to sign in", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        catch
        {
            print("could not save")
        }
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
