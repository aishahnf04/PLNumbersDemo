//
//  HistoryViewController.swift
//  PLDemo
//
//  Created by Aisha on 4/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import UIKit
import CoreData


class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var numbersLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

class HistoryViewController: PLDemoViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var historyTableView: UITableView!
    var array = [History]()
    
    override func viewWillAppear(_ animated: Bool) {
         self.getData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        // Do any additional setup after loading the view.
       
    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Numbers")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "numbers") as! String)
                print(data.value(forKey: "size") as! String)
                print(data.value(forKey: "date") as! String)
                
                let his = History.init()
                his.numbers = (data.value(forKey: "numbers") as! String)
                his.size = (data.value(forKey: "size") as! String)
                his.date = (data.value(forKey: "date") as! String)
                array.append(his)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    //table methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
            as! HistoryTableViewCell
        
        let history = array[indexPath.row] as History
        cell.dateLabel?.text = history.date
        let myStr = history.numbers.replacingOccurrences(of:"\n", with: ",")
        cell.numbersLabel.text = myStr//history.numbers
        cell.sizeLabel.text = history.size
        cell.backgroundColor = .clear
        let arr = history.numbers.components(separatedBy:"\n")
        let colorArr = ["#68d4f8","#f6a4eb","#f5be58","#fa755a","#3ecf8e","#7795f8"]
        for var item in arr {
            if(item == "") { //issue with webservice
                item = "0"
            }
            let randColor :Int  = randomInt(min: 0, max: 5)
            let color = UIColor.init(hexString:colorArr[randColor])
            let size : CGFloat  = 40//(6.0 * CGFloat((Float)(getInt(data:item)!)))
            let circle = UIView(frame: CGRect(x: 100 + (60)*CGFloat((Float)(getInt(data:item)!)), y: 180, width: 10, height: size))
            // circle.center.y = self.view.center.y
            circle.backgroundColor = color
            circle.layer.borderColor = color.cgColor
            circle.layer.cornerRadius = 5
            circle.layer.borderWidth = 2.0
            cell.addSubview(circle)
            cell.selectionStyle = .none
            circle.frame.size = CGSize(width: 0, height: 0)
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
                // Do animation
                circle.frame.size = CGSize(width: 10, height: size)
                let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                circle.transform = scaleTransform
            }, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
