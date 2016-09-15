//
//  MenuItem.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 8/29/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Foundation
import Material

class MenuItem : UIView {
    
    var title = ""
    var menu : MenuVC? = nil
    var size = 0
    
    
    internal init(menu : MenuVC, title : String, size : Int){
        super.init(frame: CGRect(x: 0, y: 0, width: Int(menu.view.frame.width), height: size))
        self.menu = menu
        self.size = size
        self.title = title
        prepare()
    }
    
    internal func setYValue(_ y : Int){
        self.frame = CGRect(x: 0, y: y, width: Int(self.frame.width), height: size)
    }
    
    internal func prepare(){
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 1))
        let botLine = UIView(frame: CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1))
        topLine.backgroundColor = Color.grey.darken1
        botLine.backgroundColor = Color.grey.darken1
        self.addSubview(topLine)
        self.addSubview(botLine)
        
        if(title == "Profile"){
            
            let profilePic = UIImage(named: "ProfileDefault1")
            _ = MainPanels.ResizeImage(profilePic!, targetSize: CGSize(width: 50, height: 50))
            let profilePicView = UIImageView(image: profilePic)
            
            profilePicView.frame = CGRect(x: 5, y: 15, width: 57, height: 50)
            self.addSubview(profilePicView)
            
            topLine.removeFromSuperview()
            let label = UILabel(frame: CGRect(x: 70, y: 15, width: self.frame.width, height: 30))
            label.text = title
            label.textAlignment = NSTextAlignment.left
            label.numberOfLines = 1
            label.font = UIFont(name: "Roboto", size: 24)
            label.adjustsFontSizeToFitWidth = true
            label.lineBreakMode = .byWordWrapping
            label.textColor = Color.red.base
            
            let label2 = UILabel(frame: CGRect(x: 70, y: 45, width: self.frame.width, height: 30))
            //CHANGE TO USERNAME OF CLIENT
            label2.text = "Sam Hollenbach"
            label2.textAlignment = NSTextAlignment.left
            label2.numberOfLines = 1
            label2.font = UIFont(name: "Scope One", size: 16)
            label2.adjustsFontSizeToFitWidth = true
            label2.lineBreakMode = .byWordWrapping
            label2.textColor = Color.white
            
            self.addSubview(label)
            self.addSubview(label2)
            
            return()
        }
        
        
        let label = UILabel(frame: CGRect(x: 35, y: self.frame.height/2-15, width: self.frame.width, height: 30))
        label.text = title
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto", size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.textColor = Color.red.base
        
        self.addSubview(label)
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = Color.grey.darken1
    }
    
    
    //Adjust this to highlight the menu item whenever you press
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        menu?.slideOut()
        
        
        if(self.title == "Log Out"){
            menu?.logout()
        }else if(self.title == "Settings"){
            menu?.settings()
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
