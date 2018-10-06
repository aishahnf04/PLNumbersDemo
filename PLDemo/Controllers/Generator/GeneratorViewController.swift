//
//  GeneratorViewController.swift
//  PLDemo
//
//  Created by Aisha on 4/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import UIKit
import CoreData

let kMaxLengthConstant:Int = 20

class GeneratorViewController: PLDemoViewController, UITextFieldDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var numberField: UITextField!
    var numberGenerated: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.textView.text = ""
        self.numberField.delegate = self
        
    }
    
    func setData() {
      self.textView.text = self.numberGenerated
    }
    
    func saveData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let entity = NSEntityDescription.entity(forEntityName: "Numbers", in: (appDelegate.context ?? nil)!)
        let newUser = NSManagedObject(entity: entity!, insertInto: (appDelegate.context ?? nil)!)
        appDelegate.context!.refresh(newUser, mergeChanges: false)
        appDelegate.context!.reset()
        newUser.setValue(self.numberField.text!, forKey: "size")
        newUser.setValue(self.textView.text!, forKey: "numbers")
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        let result = formatter.string(from: date)
        newUser.setValue(result, forKey: "date")
        
        do {
            try (appDelegate.context ?? nil)!.save()
        } catch {
            print("Failed saving")
        }
    }
    
    
    
    func getInt(_ data:String) -> Int?
    {
        return Int(data)
    }
    
    func showErrors() {
        // create the alert
        let alert = UIAlertController(title: "Enter Number", message: "Please enter number between 5 and 20", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func requestNumbers() {
      
        var request = URLRequest(url: URL(string: kBaseURL + numberField.text! + kParam )!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response ?? "")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print(responseString as Any)
            self.numberGenerated = responseString
            
        }
        
        task.resume()

    }
    
    @IBAction func generateNumbers() {
        if((numberField.text?.count) != 0) && ((Int(numberField.text!)! >= 5)){
            self.requestNumbers()
            self.setData()
        }
        else {
           self.showErrors()
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var startString = ""
        if (textField.text != nil)
        {
            startString += textField.text!
        }
        startString += string
        if let limitNumber = getInt(startString)
        {
            if limitNumber > kMaxLengthConstant
            {
                return false
            }
            else
            {
                return true;
            }
        }
        else {
         return false
        }
    }
}
