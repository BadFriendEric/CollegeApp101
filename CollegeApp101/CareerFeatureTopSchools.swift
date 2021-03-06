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
    let new : UIView = UIView(frame: CGRect(x: 0, y: 0, width: Int(MainSwipeController.Constants.ScreenWidth), height: 60))
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
        
        new.frame = CGRect(x: 0, y: bottomY, width: Int(MainSwipeController.Constants.ScreenWidth), height: 60)
        let lab : UILabel = UILabel(frame: CGRect(x: 70, y: 15, width: MainSwipeController.Constants.ScreenWidth-150, height: 30))
        lab.text = "Add new school"
        lab.textColor = Color.black
        lab.font = UIFont(name: "Vesper Libre", size: 24)
        new.addSubview(lab)
        let t = UIView(frame: CGRect(x: 0, y: 0, width: MainSwipeController.Constants.ScreenWidth, height: 1))
        let b = UIView(frame: CGRect(x: 0, y: 58, width: MainSwipeController.Constants.ScreenWidth, height: 2))
        t.backgroundColor = Color.black
        b.backgroundColor = Color.black
        
        
        //adding the + peg
        let peg = CAShapeLayer()
        let n = UILabel(frame: CGRect(x: 25, y: 5, width: 45, height: 35))
        n.text = String("+")
        n.textColor = Color.black  // set to color of other numbers
        n.font = UIFont(name: "Oswald", size: 60)
        n.zPosition = 11

        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 35,y: 30), radius: CGFloat(15), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        peg.path = circlePath.cgPath
        
        peg.lineWidth = 20
        peg.fillColor = Color.grey.lighten3.cgColor
        peg.zPosition = 10 //one less than n
        new.layer.addSublayer(peg)

        
        new.addSubview(n)
        //end of adding + peg
 
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleAddNew))
        tap.delegate = self
        new.addGestureRecognizer(tap)
        
        
        new.addSubview(t)
        new.addSubview(b)
        
        features.append(new)
        
        bottomY = Int(new.frame.maxY)
        
        refreshScrollView(bottomY)
        //updateFrame()
    }
    
    
    internal func handleAddNew(){
        new.backgroundColor = Color.white.withAlphaComponent(0.6)
        UIView.animate(withDuration: 0.8, animations: {
            self.new.backgroundColor = Color.clear
        })
        let t = TopSchoolsListItem(schoolName: "New School", feature: self)
        t.setListPosition(i: schools.count + 1)
        schools.append(t)
        //features.append(t)
        refreshList()
        scrollView.addSubview(t)
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
        
        titleLine.layer.borderColor = Color.clear.cgColor
        return features
    }
    
    
    
    
    
    
}
