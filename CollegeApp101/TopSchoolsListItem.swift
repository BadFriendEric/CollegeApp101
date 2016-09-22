//
//  TopSchoolsListItem.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 9/1/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import Foundation
import UIKit
import Material

class TopSchoolsListItem : UIView {
    
    
    var schoolName : String = ""
    var feature : CareerFeatureTopSchools? = nil
    var itemNumber = 1
    let h = CGFloat(60)
    let dot = CAShapeLayer()
    let n = UILabel(frame: CGRect(x: 30, y: 12, width: 45, height: 35))
    let l = UILabel(frame: CGRect(x: 67, y: 15, width: MainSwipeController.Constants.ScreenWidth-150, height: 30))
    let d = UIView(frame: CGRect(x: MainSwipeController.Constants.ScreenWidth-50, y: 0.0, width: 50, height: 30))
    let tl = UIView(frame: CGRect(x: 0, y: 0, width: MainSwipeController.Constants.ScreenWidth, height: 1))
    let bl = UIView(frame: CGRect(x: 0, y: 59, width: MainSwipeController.Constants.ScreenWidth, height: 1))
    let ll = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 60))
    let rl = UIView(frame: CGRect(x: MainSwipeController.Constants.ScreenWidth-2, y: 0, width: 2, height: 60))
    var pageControllerData : UIPageViewControllerDataSource? = nil
    var canMove = true
    var moving = false
    
    internal init(schoolName : String, feature : CareerFeatureTopSchools){
        super.init(frame: CGRect(x: 0, y: 0, width: Int(MainSwipeController.Constants.ScreenWidth), height: Int(h)))
        self.schoolName = schoolName
        self.feature = feature
        prepareLines()
        prepareNumberLabel()
        prepareTitleLabel()
        prepareColorLabel()
        //prepareDragIcon()
        
    }
    
    internal func setYPosition(_ y : Int){
        frame = CGRect(x: 0, y: y, width: Int(MainSwipeController.Constants.ScreenWidth), height: Int(h))
    }
    
    internal func prepareLines(){
        
        tl.backgroundColor = Color.black
        bl.backgroundColor = Color.black
        self.addSubview(tl)
        self.addSubview(bl)
    }
    
    internal func prepareColorLabel(){
        //let size = self.frame.height
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width-35,y: self.frame.height/2), radius: CGFloat(15), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        
        dot.path = circlePath.cgPath
        
        //dot.fillColor = Color.red.base.cgColor
        dot.lineWidth = 20
        self.layer.addSublayer(dot)
    }
    
    internal func prepareNumberLabel(){
        n.text = String(itemNumber) + "."
        n.textColor = Color.black
        n.font = UIFont(name: "Oswald", size: 22)
        self.addSubview(n)
    }
    
    internal func prepareTitleLabel(){
        
        l.text = schoolName
        l.textColor = Color.black
        l.font = UIFont(name: "Vesper Libre", size: 30)
        l.adjustsFontSizeToFitWidth = true
        self.addSubview(l)
        
        
    }
    
    internal func prepareDragIcon(){
        let dragImage: UIImage? = UIImage(named: "MenuIcon")
        //let imageSize = CGSize(width: 30, height: 30)
        //_ = MainPanels.ResizeImage(dragImage!, targetSize: imageSize)
        let cr = CGRect(x: MainSwipeController.Constants.ScreenWidth-45, y: 15, width: 30, height: 30)
        dragImage?.draw(in: cr)
        let dragImageView = UIImageView(image: dragImage)
        dragImageView.frame = cr
        dragImageView.image = dragImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        dragImageView.tintColor = Color.white
        self.addSubview(dragImageView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first!
        let point = touch.preciseLocation(in: self)
        
        if(point.x > self.frame.width - 50){
            canMove = false
        }else{
            canMove = true
            if(self.feature?.myVC.pageViewController.dataSource != nil){
                pageControllerData = self.feature?.myVC.pageViewController.dataSource
                self.feature?.myVC.pageViewController.dataSource = nil
                
            }
            
        }
        //print(String(describing: point.x) + ", " + String(describing: point.y) + ", " + String(itemNumber))
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first!
        let point = touch.preciseLocation(in: self)
        let moveColor = Color.blue.darken3
        
        
        if(!canMove){
            return
        }
        if(canMove && !moving){
            moving = true
            self.feature?.scrollView.isScrollEnabled = false
            tl.backgroundColor = moveColor
            bl.backgroundColor = moveColor
            ll.backgroundColor = moveColor
            rl.backgroundColor = moveColor
            self.addSubview(ll)
            self.addSubview(rl)
            l.font = UIFont(name: "VesperLibre-Heavy", size: 30)
            self.backgroundColor = Color.black.withAlphaComponent(0.2)
            

            //Used to disable MainPanel paging swipe
            
        }
        
        
        if(true){
            if(point.y < -20){
                if(self.itemNumber > 1){
                    feature?.swapItems(a: self.itemNumber, b: self.itemNumber-1)
                }
                
            }
            if(point.y > self.frame.height+20){
                if(self.itemNumber < (feature?.schools.count)!-1){
                    feature?.swapItems(a: self.itemNumber, b: self.itemNumber+1)
                }
            }
        }
        
        
        
        
        
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first!
        let point = touch.preciseLocation(in: self)
        if(point.x > self.frame.width-50){
            if(dot.fillColor == Color.red.base.cgColor){
                dot.fillColor = Color.green.lighten1.cgColor
            }else if(dot.fillColor == Color.blue.darken1.cgColor){
                dot.fillColor = Color.red.base.cgColor
            }else if(dot.fillColor == Color.green.lighten1.cgColor){
                dot.fillColor = Color.blue.darken1.cgColor
            }
            return
        }
        
        if(moving){
            
            dropItem()
        }else{
            self.backgroundColor = Color.white.withAlphaComponent(0.6)
            UIView.animate(withDuration: 0.8, animations: {
                self.backgroundColor = Color.clear
            })

        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        dropItem()
    }
    
    internal func dropItem(){
        canMove = false
        moving = false
        self.feature?.scrollView.isScrollEnabled = true
        tl.backgroundColor = Color.black
        bl.backgroundColor = Color.black
        ll.removeFromSuperview()
        rl.removeFromSuperview()
        l.font = UIFont(name: "Vesper Libre", size: 30)
        self.backgroundColor = Color.clear
        //UIView.animate(withDuration: 0.5, animations: {})

        self.feature?.myVC.pageViewController.dataSource = pageControllerData
    }
    
    internal func refreshTitle(){
        n.text = String(itemNumber) + "."
        l.text = schoolName
    }
    
    internal func setListPosition(i : Int){
        self.itemNumber = i
        if(itemNumber <= 2){
            dot.fillColor = Color.red.base.cgColor
        }else if(itemNumber <= 7){
            dot.fillColor = Color.blue.darken1.cgColor
        }else if(itemNumber <= 10){
            dot.fillColor = Color.green.lighten1.cgColor
        }
        refreshTitle()
    }
    
    //internal func
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
