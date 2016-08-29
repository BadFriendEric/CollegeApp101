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
    
    var x = 0
    var y = 0
    var width = MainSwipeController.Constants.ScreenWidth
    var height = 90
    
    var type : PlannerItemType = .Note
    
    var cfp : CareerFeaturePlanner? = nil
    
    
    
    internal init(cfp : CareerFeaturePlanner, y : Int) {
        self.cfp = cfp
        self.y = y
        //updateFrame()
        super.init(frame : CGRect(x: CGFloat(self.x), y: CGFloat(self.y), width: CGFloat(self.width), height: CGFloat(self.height)))
        setupView()
    }
    internal init(cfp : CareerFeaturePlanner, type : PlannerItemType,y : Int) {
        self.cfp = cfp
        self.type = type
        self.y = y
        //updateFrame()
        super.init(frame : CGRect(x: CGFloat(self.x), y: CGFloat(self.y), width: CGFloat(self.width), height: CGFloat(self.height)))
        setupView()
    }
    
    internal func setupView(){
        backgroundColor = self.cfp!.featureColor
        
        prepareTopBottomLines()
        
        
        
    }
    
    internal func prepareTopBottomLines(){
        let topLine = UIView(frame: CGRect(x: 0.0,y: 0.0,width: self.width,height: 1))
        topLine.layer.borderWidth = 1.0
        topLine.layer.borderColor = UIColor.whiteColor().CGColor
        
        let bottomLine = UIView(frame: CGRect(x: CGFloat(0.0),y: CGFloat(self.height-1),width: CGFloat(self.width),height: CGFloat(1)))
        bottomLine.layer.borderWidth = 1.0
        bottomLine.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.addSubview(topLine)
        self.addSubview(bottomLine)
        

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    internal func updateFrame(){
        self.frame = CGRect(x: CGFloat(self.x), y: CGFloat(self.y), width: CGFloat(self.width), height: CGFloat(self.height))
    }
    internal func setYPosition(y : Int){
        self.y = y
        updateFrame()
    }
    internal func setItemHeight(height : Int){
        self.height = height
        updateFrame()
    }
    
    
    
    
    
}