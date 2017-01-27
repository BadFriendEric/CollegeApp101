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

class HubCard: Card {
    
    var trash: IconButton = IconButton()
    var trashClicked = false
    var vc: MainPanels! = MainPanels()
    var icon: UIImage = UIImage()
    let trashImg: UIImage? = Icon.cm.close
    var type : String! = "Default"
    var mysubviews = [UIView]()
    
    let iconSize = 50
    
    
    
    internal init(vc: MainPanels,type: String, x: Int, y: Int, width: Int, height: Int){
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.vc = vc
        self.type = type
        
        backgroundColor = Color.white
        cornerRadiusPreset = .cornerRadius3
        
        
        setTrashButton()
        setIcon()
        setMainText("Welcome to College App 101, Press the Help icon in the top right to learn more!")
        reload()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reload() {
        for v in subviews {
            v.removeFromSuperview()
        }
        for v in mysubviews {
            self.addSubview(v)
        }
    }
    
    internal func addView(_ v: UIView?){
        mysubviews.append(v!)
    }
    
    
    internal func setIcon(){

        
        switch(type){
        case "Default" :
            self.icon = UIImage(named: "LightbulbIcon")!
            break
            
        default :
            self.icon = UIImage(named: "CA101LogoOutline")!
        }
        
        _ = MainPanels.ResizeImage(icon, targetSize: CGSize(width: iconSize, height: iconSize))
        //self.icon.tintWithColor(MainPanels.Constants.Color3)
        let iconView = UIImageView(image: self.icon)
        iconView.frame = CGRect(x: 10, y: 20, width: iconSize, height: iconSize)
        mysubviews.append(iconView)
        
    }
    
    internal func setMainText(_ text: String){
        let lab = UILabel(frame: CGRect(x: iconSize + 20, y: 0, width: Int(self.frame.width) - iconSize - 50, height: Int(self.frame.height)-25))
        lab.text = text
        lab.font = UIFont(name: "Baskerville", size: 18)
        lab.numberOfLines = 4
        lab.adjustsFontSizeToFitWidth = true
        lab.lineBreakMode = .byWordWrapping
        mysubviews.append(lab)

        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if(trashClicked){
            resetTrashButton()
        }
        
    }
    
    
    internal func setTrashButton(){
        trash = IconButton(frame: CGRect(x: Int(self.frame.width)-45, y: 0, width: 50, height: 35))
        trash.pulseColor = Color.red.base
        trash.tintColor = Color.black
        trash.setImage(trashImg, for: UIControlState())
        trash.setImage(trashImg, for: .highlighted)
        trash.addTarget(self, action: #selector(handleTrashButton), for: .touchUpInside)
        
        mysubviews.append(trash)
    }
    
    internal func resetTrashButton(){
        //let trashImg: UIImage? = Icon.cm.close
        trash.tintColor = Color.black
        //trash.setImage(trashImg, forState: .Normal)
        //trash.setImage(trashImg, forState: .Highlighted)
        UIView.animate(withDuration: 0.2, animations: {
            self.trash.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI/2))
        }, completion: { finished in
            self.trash.transform = CGAffineTransform.identity
        })
        trashClicked = false
    }
    
    
    internal func handleTrashButton(){
        if(trashClicked){
            vc.deleteHubCard(self)
        }else{
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .allowUserInteraction, animations: {
                self.trash.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2))
            }, completion: { finished in
                self.trash.transform = CGAffineTransform.identity
            })
            trash.tintColor = Color.red.base
                        trashClicked = true
        }
        
    }
    
    internal func getSuperview() -> UIView?{
        return self.superview!
    }
    
    
    
    
    
    
}
