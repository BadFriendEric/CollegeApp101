//
//  CareerFeatureTopSchools.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 8/10/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Foundation
import Material

open class CareerFeatureTopSchools : CareerFeature {
 
    //0 for List View, 1 for Search View
    var currentView : Int = 0
    var schools : [TopSchoolsListItem]! = [TopSchoolsListItem]()
    var bottomY = 10
    
    public override init() {
        super.init()
        prepareList()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func prepareList(){
        
        for i in 0..<10 {
            let t = TopSchoolsListItem(schoolName: "MySchool University #"+String(i+1), feature: self)
            t.setListPosition(i: i + 1)
            schools.append(t)
        }
        
        
        
        refreshList()
        
        
    }
    
    
    open func swapItems(a : Int, b : Int){
        
        let t = schools[a-1]
        schools[a-1] = schools[b-1]
        schools[b-1] = t
        refreshList()
    }
    
    open func refreshList(){
        bottomY = 2
        let tl = UIView(frame: CGRect(x: 0, y: bottomY-1, width: Int(MainSwipeController.Constants.ScreenWidth), height: 1))
        tl.backgroundColor = Color.black
        features.append(tl)
        var i = 1
        for s in schools {
            s.setYPosition(bottomY)
            s.itemNumber = i
            i += 1
            bottomY = Int(s.frame.maxY)
            //print(bottomY)
            features.append(s)
            s.refreshTitle()
            
        }
        
        let new : UIView = UIView(frame: CGRect(x: 0, y: bottomY, width: Int(MainSwipeController.Constants.ScreenWidth), height: 60))
        let lab : UILabel = UILabel(frame: CGRect(x: 70, y: 15, width: MainSwipeController.Constants.ScreenWidth-150, height: 30))
        lab.text = "+ Add new item"
        lab.textColor = Color.black
        lab.font = UIFont(name: "Vesper Libre", size: 30)
        new.addSubview(lab)
        let t = UIView(frame: CGRect(x: 0, y: 0, width: MainSwipeController.Constants.ScreenWidth, height: 1))
        let b = UIView(frame: CGRect(x: 0, y: 58, width: MainSwipeController.Constants.ScreenWidth, height: 2))
        t.backgroundColor = Color.black
        b.backgroundColor = Color.black
        new.addSubview(t)
        new.addSubview(b)
        
        features.append(new)
        
        bottomY = Int(new.frame.maxY)
        
        refreshScrollView(bottomY)
        //updateFrame()
    }
    
    
    open override func setFrame(_ x: Int, y: Int, width: Int, height: Int) {
        super.setFrame(x, y: y, width: width, height: height)
        setFeatureTitle("Top Schools")
        //refreshScrollView(height)
    }
    
    open override func updateFrame(){
        super.updateFrame()
    }
    
    open override func getFeatures() -> [UIView] {
        //titleLine.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        titleLine.layer.color = Color.clear
        titleLine.layer.borderColor = Color.clear.cgColor
        return features
    }
    
    
    
    
    
    
}
