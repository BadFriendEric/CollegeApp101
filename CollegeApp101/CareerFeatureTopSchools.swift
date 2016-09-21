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
        
        bottomY = 10
        let tl = UIView(frame: CGRect(x: 0, y: bottomY-2, width: Int(MainSwipeController.Constants.ScreenWidth), height: 2))
        tl.backgroundColor = Color.white
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
        return features
    }
    
    
    
    
    
    
}
