//
//  GeneratorInfoView.swift
//  PLDemo
//
//  Created by Aisha on 4/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import UIKit

class GeneratorInfoView: UIView {
   var arr = [String](){
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        arr = arr.filter({ $0 != ""}) // issue with webservice
        let colorArr = ["#68d4f8","#f6a4eb","#f5be58","#fa755a","#3ecf8e","#7795f8"]
        for var item in arr {
            if(item == "") { //issue with webservice
                item = "0"
            }
        
            let randY :Int  = randomInt(min: 1, max: 5)
            let randColor :Int  = randomInt(min: 0, max: 5)
            let color = UIColor.init(hexString:colorArr[randColor])
            let size : CGFloat  = 40//(6.0 * CGFloat((Float)(getInt(data:item)!)))
            let y : CGFloat =  CGFloat((Float)(getInt(data:item)!))+CGFloat((Float)(randY))*15 + CGFloat((Float)(randY))*40
            let x : CGFloat = CGFloat((Float)(getInt(data:item)!)) + CGFloat((randColor * 60))
            let circle = UIView(frame: CGRect(x:x, y:y, width: size, height: size))
        
            // circle.center.y = self.view.center.y
            circle.backgroundColor = color
            circle.layer.borderColor =  color.cgColor
            circle.layer.cornerRadius = 20
            circle.layer.borderWidth = 2.0
            // add shodow
            circle.layer.shadowColor = UIColor.gray.cgColor
            circle.layer.shadowOffset = CGSize(width: 2, height: 5)
            circle.layer.shadowOpacity = 0.5
            circle.layer.shadowRadius = 1.0
            circle.clipsToBounds = false
            self.addText(text: item, view: circle,color: .white,sized: CFloat(size))
            self.addSubview(circle)
            
            let originalTransform = circle.transform
            let scaledTransform = originalTransform.scaledBy(x: 1.0, y: 1.0)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 600.0)
            UIView.animate(withDuration: 0.3, animations: {
                circle.transform = scaledAndTranslatedTransform
            })
            circle.frame.size = CGSize(width: 0, height: 0)
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
                // Do animation
                circle.frame.size = CGSize(width: size, height: size)
                let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                circle.transform = scaleTransform
            }, completion: nil)
        }
    }
    
    func addText(text : String, view: UIView , color:UIColor, sized: CFloat) {
        let textRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height) // rect to display the view in
        let textMask = CATextLayer()
        textMask.contentsScale = (UIScreen.screens.last?.scale ?? nil)! // sets the layer's scale to the main screen scale
        textMask.frame = CGRect(origin: CGPoint(x:0,y:0), size: textRect.size)
        textMask.foregroundColor = UIColor.white.cgColor // an opaque color so that the mask covers the text
        textMask.string = text // your text here
        textMask.font = UIFont.boldSystemFont(ofSize:1) // your font here
        textMask.alignmentMode = CATextLayerAlignmentMode.center // centered text
        
        let bgView = UIView(frame: textRect)
        bgView.backgroundColor = color
        bgView.layer.mask = textMask // mask the view to the textMask
        let scaleTransform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        bgView.transform = scaleTransform
        view.addSubview(bgView)
    }
    
}
