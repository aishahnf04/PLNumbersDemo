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
    override func prepareForReuse() -> Void {
        sizeLabel.text = nil
        numbersLabel.text = nil
        dateLabel.text = nil
    }
    
}


class HistoryViewController: PLDemoViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var historyTableView: UITableView!
    var array = [History]()
    
    override func viewWillAppear(_ animated: Bool) {
       self.array.removeAll()
       self.getData()
       self.historyTableView.reloadData()
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
        tableView.setValue(nil, forKey: "_reusableTableCells")
        let history = array[indexPath.row] as History
        cell.dateLabel?.text = history.date
        let myStr = history.numbers.replacingOccurrences(of:"\n", with: ",")
        cell.numbersLabel.text = myStr//history.numbers
        cell.sizeLabel.text = history.size
        cell.backgroundColor = .clear
        var arr = history.numbers.components(separatedBy:"\n")
        arr = arr.filter({ $0 != ""}) // issue with webservice
        var count : Int = 0
        let colorArr = ["#68d4f8","#f6a4eb","#f5be58","#fa755a","#3ecf8e","#7795f8"]
        for var item in arr {
            if(item == "") { //issue with webservice
                item = "0"
            }
            count = count + 1
            let randColor :Int  = randomInt(min: 0, max: 5)
            let color = UIColor.init(hexString:colorArr[randColor])
            let size : CGFloat  = CGFloat(10) + (10)*CGFloat((Float)(getInt(data:item)!))
            let circle = UIView(frame: CGRect(x: 100 + count * 10, y: 50, width: 4, height: Int(size)))
            // circle.center.y = self.view.center.y
            circle.backgroundColor = color
            circle.layer.borderColor = color.cgColor
            circle.layer.cornerRadius = 2
            circle.layer.borderWidth = 2.0
            cell.addSubview(circle)
            cell.selectionStyle = .none
            circle.transform = CGAffineTransform(scaleX: 1,y: -1);
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(kMaxSize)
    }
    
    
}
