//
//  HubCard.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 7/31/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Foundation
import Material

class HubCard: CardView {
    
    var trash: IconButton = IconButton()
    var trashClicked = false
    var vc: MainPanels! = MainPanels()
    var icon: UIImage = UIImage()
    let trashImg: UIImage? = MaterialIcon.cm.close
    var type : String! = "Default"
    var mysubviews = [UIView]()
    
    let iconSize = 50
    
    
    
    internal init(vc: MainPanels,type: String, x: Int, y: Int, width: Int, height: Int){
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.vc = vc
        divider = false
        self.type = type
        contentInset = UIEdgeInsetsZero
        contentViewInset = UIEdgeInsetsZero
        leftButtonsInset = UIEdgeInsetsZero
        rightButtonsInset = UIEdgeInsetsZero
        titleLabelInset = UIEdgeInsetsZero
        
        
        setTrashButton()
        setIcon()
        setMainText("Hub Card Test with more words and i like pancakes adn syrup too and i just neded more words on here for the example")
        reloadView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadView() {
        for v in subviews {
            v.removeFromSuperview()
        }
        for v in mysubviews {
            self.addSubview(v)
        }
    }
    
    internal func addView(v: UIView?){
        mysubviews.append(v!)
    }
    
    
    internal func setIcon(){

        
        switch(type){
        case "Default" :
            self.icon = UIImage(named: "CA101LogoOutline")!
            break
            
        default : break
            self.icon = UIImage(named: "CA101LogoOutline")!
        }
        
        MainPanels.ResizeImage(icon, targetSize: CGSize(width: iconSize, height: iconSize))
        //self.icon.tintWithColor(MainPanels.Constants.Color3)
        let iconView = UIImageView(image: self.icon)
        iconView.frame = CGRect(x: 15, y: 35, width: iconSize, height: iconSize)
        mysubviews.append(iconView)
        
    }
    
    internal func setMainText(text: String){
        let lab = UILabel(frame: CGRect(x: iconSize + 20, y: 0, width: Int(self.frame.width) - iconSize - 50, height: Int(self.frame.height)-35))
        lab.text = text
        lab.font = RobotoFont.thinWithSize(18)
        lab.numberOfLines = 3
        lab.adjustsFontSizeToFitWidth = true
        lab.lineBreakMode = .ByWordWrapping
        mysubviews.append(lab)

        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if(trashClicked){
            resetTrashButton()
        }
        
    }
    
    
    internal func setTrashButton(){
        trash = IconButton(frame: CGRect(x: Int(self.frame.width)-45, y: 0, width: 50, height: 35))
        trash.pulseColor = MaterialColor.red.base
        trash.tintColor = MaterialColor.black
        trash.setImage(trashImg, forState: .Normal)
        trash.setImage(trashImg, forState: .Highlighted)
        trash.addTarget(self, action: #selector(handleTrashButton), forControlEvents: .TouchUpInside)
        
        mysubviews.append(trash)
    }
    
    internal func resetTrashButton(){
        //let trashImg: UIImage? = MaterialIcon.cm.close
        trash.tintColor = MaterialColor.black
        //trash.setImage(trashImg, forState: .Normal)
        //trash.setImage(trashImg, forState: .Highlighted)
        UIView.animateWithDuration(0.2, animations: {
            self.trash.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI/2))
        }, completion: { finished in
            self.trash.transform = CGAffineTransformIdentity
        })
        trashClicked = false
    }
    
    
    internal func handleTrashButton(){
        if(trashClicked){
            vc.deleteHubCard(self)
        }else{
            UIView.animateWithDuration(0.2, delay: 0.0, options: .AllowUserInteraction, animations: {
                self.trash.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
            }, completion: { finished in
                self.trash.transform = CGAffineTransformIdentity
            })
            trash.tintColor = MaterialColor.red.base
                        trashClicked = true
        }
        
    }
    
    internal func getSuperview() -> UIView?{
        return self.superview!
    }
    
    
    
    
    
    
}