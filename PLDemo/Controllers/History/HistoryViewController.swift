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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Numbers")
      
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context!.fetch(request)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        NSLog("sections")
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("rows")
        return array.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // NSLog("get cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
                    as! HistoryTableViewCell
        
                let history = array[indexPath.row] as History
                cell.dateLabel?.text = history.date
       let myStr = history.numbers.replacingOccurrences(of:"\n", with: ",")
        
                cell.numbersLabel.text = myStr//history.numbers
                cell.sizeLabel.text = history.size
                return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 124
    }

    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
//            as! HistoryTableViewCell
//
////        let headline = headlines[indexPath.row]
////        cell.headlineTitleLabel?.text = headline.title
////        cell.headlineTextLabel?.text = headline.text
////        cell.headlineImageView?.image = UIImage(named: headline.image)
//
//        return cell
//    }
}
