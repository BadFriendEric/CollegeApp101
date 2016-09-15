//
//  PlannerItem.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 8/11/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Foundation
import Material

class PlannerItem : UIView {
    
    enum PlannerItemType {
        case Note
        case Reminder
        case List
    }
    
    var x1 = 0
    var y1 = 0
    var width1 = MainSwipeController.Constants.ScreenWidth
    var height1 = 90
    
    
    var type : PlannerItemType = .Note
    
    var cfp : CareerFeatureTopSchools? = nil
    
    
    
    internal init(cfp : CareerFeatureTopSchools, y : Int) {
        super.init(frame : CGRect(x: CGFloat(self.x1), y: CGFloat(y), width: CGFloat(self.width1), height: CGFloat(self.height1)))
        self.cfp = cfp
        self.y1 = y
        
        //updateFrame()
        
        setupView()
    }
    internal init(cfp : CareerFeatureTopSchools, type : PlannerItemType,y : Int) {
        super.init(frame : CGRect(x: CGFloat(self.x1), y: CGFloat(y), width: CGFloat(self.width1), height: CGFloat(self.height1)))
        self.cfp = cfp
        self.type = type
        self.y1 = y
        
        //updateFrame()
        
        setupView()
    }
    
    internal func setupView(){
        backgroundColor = self.cfp!.featureColor
        
        prepareTopBottomLines()
        
        
        
    }
    
    internal func prepareTopBottomLines(){
        let topLine = UIView(frame: CGRect(x: 0.0,y: 0.0,width: self.width1,height: 1))
        topLine.layer.borderWidth = 1.0
        topLine.layer.borderColor = UIColor.white.cgColor
        
        let bottomLine = UIView(frame: CGRect(x: CGFloat(0.0),y: CGFloat(self.height1-1),width: CGFloat(self.width),height: CGFloat(1)))
        bottomLine.layer.borderWidth = 1.0
        bottomLine.layer.borderColor = UIColor.white.cgColor
        
        self.addSubview(topLine)
        self.addSubview(bottomLine)
        

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    internal func updateFrame(){
        self.frame = CGRect(x: CGFloat(self.x1), y: CGFloat(self.y1), width: CGFloat(self.width1), height: CGFloat(self.height1))
    }
    internal func setYPosition(y : Int){
        self.y1 = y
        updateFrame()
    }
    internal func setItemHeight(height : Int){
        self.height1 = height
        updateFrame()
    }
    
    
    
    
    
}
