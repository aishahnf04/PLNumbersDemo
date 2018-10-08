//
//  PLDemoViewController.swift
//  PLDemo
//
//  Created by Aisha on 5/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import UIKit

class PLDemoViewController: UIViewController {
    var myColor = UIColor(red:(196/255), green:(240/255), blue:1, alpha:1.0)
    var myBarColor = UIColor(red:(33/255), green:(122/255), blue:(183/255), alpha:1.0)
    var activityContainer: UIView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = myColor
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
    
    
    func showErrorMessage(view: UIViewController) {
        let alert = UIAlertController(title: "Enter Number", message: "Please enter number between 5 and 20", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    func showErrorMessage(view: UIViewController, message:String) {
        let alert = UIAlertController(title: "Error", message:message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicatory(uiView: UIView) {
        activityContainer = UIView()
        activityContainer!.frame = uiView.frame
        activityContainer!.center = uiView.center
        activityContainer!.backgroundColor = .clear
        
        let loadingView: UIView = UIView()
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 80, height: 80))
        loadingView.frame = rect//CGRect(origin:CGPoint(0,0), size:CGSize(80,80))//CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = myBarColor
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let rect1 = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 40, height: 40))
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = rect1
        actInd.style = UIActivityIndicatorView.Style.whiteLarge
        actInd.center = CGPoint(x:loadingView.frame.size.width / 2,y:
                                    loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        activityContainer!.addSubview(loadingView)
        uiView.addSubview(activityContainer!)
        actInd.startAnimating()
    }
    
    func removeActivityIndicatory(uiView: UIView) {
        self.activityContainer!.removeFromSuperview()
    }
}
