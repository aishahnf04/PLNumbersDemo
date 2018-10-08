//
//  GeneratorViewController.swift
//  PLDemo
//
//  Created by Aisha on 4/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import UIKit
import CoreData

class GeneratorViewController: PLDemoViewController, UITextFieldDelegate {
    @IBOutlet weak var numberField: UITextField!
    var generatorView : GeneratorInfoView!
    var numberGenerated: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func generateNumbers() {
    if((numberField.text?.count) != 0) && ((Int(numberField.text!)! >= 5)){
        self.showActivityIndicatory(uiView: self.view)
        GetAllNum(max: numberField.text!).executeWithoutJSON(
            onSuccess: { (string: String) in
                print(string)
                self.removeActivityIndicatory(uiView: self.view)
                self.numberGenerated = string
                self.setLayout()
                self.saveData()
        },
            onError: { (error: Error) in
                error.printDescription()
                self.showErrorMessage(view:self, message:error.localizedDescription)
                self.removeActivityIndicatory(uiView: self.view)
        })
    }
    else {
        self.showErrorMessage(view:self) }
    }
    
    func setLayout() {
    let arr = self.numberGenerated.components(separatedBy:"\n")
        if((self.generatorView) != nil) {
        self.generatorView.removeFromSuperview()
    }
    self.generatorView = GeneratorInfoView(frame:CGRect(x:0,y:100,width:200,height:200))
    self.generatorView.arr = arr
    self.view.addSubview(self.generatorView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if((self.generatorView) != nil) {
            self.generatorView.removeFromSuperview()
        }
    }
    
    func saveData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Numbers", in: (context ))
        let numb = NSManagedObject(entity: entity!, insertInto: (context ))
        numb.setValue(self.numberField.text!, forKey: "size")
        numb.setValue(self.numberGenerated!, forKey: "numbers")

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"

        let result = formatter.string(from: date)
        numb.setValue(result, forKey: "date")
        appDelegate.saveContext()
        do {
            try (context.save())
            
        } catch {
            print("Failed saving")
        }
       
    }
    
    
}
