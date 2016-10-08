//
//  TopSchoolsListItem.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 9/1/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//
//
//
// IDEAS FOR IMPROVEMENT: 
//
//  ANIMATION:
//
//      Right now, when you swipe a school up or down you only see the change once it
//      "snaps into place".  I want to make the numbers stay in place alwasys but have the rest of the information (difficulty, text, etc)
//      to follow the users finger.


import Foundation
import UIKit
import Material

class TopSchoolsListItem : UIView {
    
    
    var schoolName : String = ""
    var feature : CareerFeatureTopSchools? = nil
    var itemNumber = 1
    let h = CGFloat(60)
    let dot = CAShapeLayer()
    let dragIcon = CAShapeLayer()
    let n = UILabel(frame: CGRect(x: 30, y: 12, width: 45, height: 35))
    let l = UILabel(frame: CGRect(x: 67, y: 5, width: MainSwipeController.Constants.ScreenWidth-130, height: 50))
    let d = UIView(frame: CGRect(x: MainSwipeController.Constants.ScreenWidth-50, y: 0.0, width: 50, height: 30))
    let tl = UIView(frame: CGRect(x: 0, y: 0, width: MainSwipeController.Constants.ScreenWidth, height: 1))
    let bl = UIView(frame: CGRect(x: 0, y: 59, width: MainSwipeController.Constants.ScreenWidth, height: 1))
    let ll = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 60))
    let rl = UIView(frame: CGRect(x: MainSwipeController.Constants.ScreenWidth-2, y: 0, width: 2, height: 60))
    let bgTint:UIView = UIView(frame: CGRect(x: 0, y: 0, width: MainSwipeController.Constants.ScreenWidth, height: 60))
    let peg = CAShapeLayer()
    var pageControllerData : UIPageViewControllerDataSource? = nil
    var canMove = true
    var moving = false
    let listColor = Color.grey.darken3
    
    internal init(schoolName : String, feature : CareerFeatureTopSchools){
        super.init(frame: CGRect(x: 0, y: 0, width: Int(MainSwipeController.Constants.ScreenWidth), height: Int(h)))
        self.schoolName = schoolName
        self.feature = feature
        prepareLines()
        prepareNumberLabel()
        prepareTitleLabel()
        prepareColorLabel()
        prepareTriagleIcon()
    }
    
    internal func setYPosition(_ y : Int){
        frame = CGRect(x: 0, y: y, width: Int(MainSwipeController.Constants.ScreenWidth), height: Int(h))
    }
    
    internal func prepareLines(){
        
        tl.backgroundColor = listColor
        bl.backgroundColor = listColor
        self.addSubview(tl)
        self.addSubview(bl)
    }
    
    internal func prepareTriagleIcon(){
        //let size = self.frame.height
        //let triPath = UIBezierPath(cgPath: <#T##CGPath#>)
        
        let myBezier = UIBezierPath()
//        myBezier.move(to: CGPoint(x: 0, y: self.frame.height/2))
//        myBezier.addLine(to: CGPoint(x: 20, y: self.frame.height/2))
//        myBezier.addLine(to: CGPoint(x: 10, y: self.frame.height/2))
//        myBezier.close()
        
        dragIcon.path = myBezier.cgPath
        
        
        //dot.fillColor = Color.red.base.cgColor
        dragIcon.lineWidth = 20
        dragIcon.fillColor = listColor.cgColor
        //self.layer.addSublayer(dragIcon)
    }
    
    internal func refreshTriangle(y : Int){
        let myBezier = UIBezierPath()
        myBezier.move(to: CGPoint(x: 5, y: self.frame.height/2))
        myBezier.addLine(to: CGPoint(x: 30, y: self.frame.height/2))
        myBezier.addLine(to: CGPoint(x: 17.5, y: Double(y)))
        
//        myBezier.move(to: CGPoint(x: 10, y: self.frame.height/2))
//        myBezier.addLine(to: CGPoint(x: 0, y: y))
//        myBezier.addLine(to: CGPoint(x: 20, y: y))
        myBezier.close()
        
        dragIcon.path = myBezier.cgPath
        
        self.layer.addSublayer(dragIcon)
    }

    
    internal func prepareColorLabel(){
        //let size = self.frame.height
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width-35,y: self.frame.height/2), radius: CGFloat(15), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        dot.path = circlePath.cgPath
        
        //dot.fillColor = Color.red.base.cgColor
        dot.lineWidth = 2
        dot.strokeColor = Color.white.cgColor
        dot.fillColor = Color.blue.darken1.cgColor
        dot.zPosition = 11
        self.layer.addSublayer(dot)
        
        
        bgTint.backgroundColor = Color.blue.darken1.withAlphaComponent(0.4)
        bgTint.zPosition = 0
        self.addSubview(bgTint)
        
    }
    
    internal func prepareNumberLabel(){
        n.text = String(itemNumber)
        n.textColor = listColor
        n.font = UIFont(name: "Oswald", size: 22)
        n.zPosition = 11
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 35,y: self.frame.height/2), radius: CGFloat(15), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        print(self.frame.height/2)

        peg.path = circlePath.cgPath
        
        peg.lineWidth = 20
        peg.fillColor = Color.grey.lighten3.cgColor
        self.layer.addSublayer(peg)
        peg.zPosition = 10 //one less than n
        
        self.addSubview(n)
    }
    
    internal func prepareTitleLabel(){
        
        l.text = schoolName
        l.textColor = listColor
        l.font = UIFont(name: "Vesper Libre", size: 24)
        l.adjustsFontSizeToFitWidth = true
        l.zPosition = 11
        self.addSubview(l)
        
        
    }
  
    /*
    internal func prepareMovingBox(t: UITouch){
        
        let point = t.preciseLocation(in: self)
        let boxW = MainSwipeController.Constants.ScreenWidth - 10
        let boxH: CGFloat = 50
        
        let movingBox: UIView = UIView(frame: CGRect(x: 5, y: point.y - boxH, width: boxW, height: boxH))
        movingBox.backgroundColor = Color.red.lighten2
        self.addSubview(movingBox)
        
        
    }
    */
    
    
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
            UIView.animate(withDuration: 0.3, animations: {
                self.backgroundColor = Color.grey.lighten3.withAlphaComponent(0.7)  //changed from black.withAlphaComponent(0.2)
            })
            
            
            //Used to disable MainPanel paging swipe
            
        }
        
        
        let h = self.frame.height/2
        let y = point.y
        let ya = abs(y-h)
        
        var yt = (y-h)*(ya/(ya+35)) + h
        
        if(yt < 0){
            yt = 0
        }else if(yt > self.frame.height){
            yt = self.frame.height
        }
        
        let f = Float(ya / (h+20))
        
        
        
        if(y > h){
            dragIcon.fillColor = UIColor(colorLiteralRed: f, green: 0, blue: 0, alpha: 0.9).cgColor
        }else{
            dragIcon.fillColor = UIColor(colorLiteralRed: 0, green: f, blue: 0, alpha: 0.9).cgColor
        }
        

        
        if(itemNumber == 1 && y < h){
            dragIcon.removeFromSuperlayer()
        }else if(itemNumber == feature?.schools.count && y > h){
            dragIcon.removeFromSuperlayer()
        }else{
            refreshTriangle(y: Int(yt))
        }
        
        
        if(point.y < -20){
            if(self.itemNumber > 1){
                feature?.swapItems(a: self.itemNumber, b: self.itemNumber-1)
            }
                
        }
        if(point.y > self.frame.height+20){
            if(self.itemNumber < (feature?.schools.count)!){
                feature?.swapItems(a: self.itemNumber, b: self.itemNumber+1)
            }
        }
        
        
        
        
        
        
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first!
        let point = touch.preciseLocation(in: self)
        if(point.x > self.frame.width-50){
            if(dot.fillColor == Color.red.base.cgColor){
                dot.fillColor = Color.green.lighten1.cgColor
                bgTint.backgroundColor = Color.green.lighten1.withAlphaComponent(0.7)
            }else if(dot.fillColor == Color.blue.darken1.cgColor){
                dot.fillColor = Color.red.base.cgColor
                bgTint.backgroundColor = Color.red.base.withAlphaComponent(0.7)
            }else if(dot.fillColor == Color.green.lighten1.cgColor){
                dot.fillColor = Color.blue.darken1.cgColor
                bgTint.backgroundColor = Color.blue.darken1.withAlphaComponent(0.7)
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
        self.feature?.myVC.pageViewController.dataSource = pageControllerData
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        dropItem()
        self.feature?.myVC.pageViewController.dataSource = pageControllerData
    }
    
    internal func dropItem(){
        dragIcon.removeFromSuperlayer()
        canMove = false
        moving = false
        self.feature?.scrollView.isScrollEnabled = true
        tl.backgroundColor = listColor
        bl.backgroundColor = listColor
        ll.removeFromSuperview()
        rl.removeFromSuperview()
        l.font = UIFont(name: "Vesper Libre", size: 30)
        
        //MAY HAVE TO MAKE THIS CANCELLABLE BUT IDK
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundColor = Color.clear
        })
        self.feature?.myVC.pageViewController.dataSource = pageControllerData
    }
    
    internal func refreshTitle(){
        n.text = String(itemNumber)
        l.text = schoolName
    }
    
    internal func setListPosition(i : Int){
        self.itemNumber = i
        if(itemNumber <= 2){
            dot.fillColor = Color.red.base.cgColor
            bgTint.backgroundColor = Color.red.base.withAlphaComponent(0.7)
        }else if(itemNumber <= 7){
            dot.fillColor = Color.blue.darken1.cgColor
            bgTint.backgroundColor = Color.blue.darken1.withAlphaComponent(0.7)
        }else if(itemNumber <= 10){
            dot.fillColor = Color.green.lighten1.cgColor
            bgTint.backgroundColor = Color.green.lighten1.withAlphaComponent(0.7)
        }
        refreshTitle()
    }
    
    //internal func
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
