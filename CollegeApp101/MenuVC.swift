//
//  MenuVC.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 8/6/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import Foundation
import UIKit
import Material
// import EZSwipeController // if using CocoaPods
class MenuVC : UIViewController {

    let mainWidth = EZSwipeController.Constants.ScreenWidth
    let width = EZSwipeController.Constants.ScreenWidth * 0.7
    let height = EZSwipeController.Constants.ScreenHeight
    
    var x : CGFloat = 0.0
    var y : CGFloat = 0.0
    
    var menuBacker: UIView! = UIView()
    
    var open = false
    
    internal init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func setupView(){
        menuBacker.frame = CGRect(x: 0, y: 0, width: mainWidth, height: height)
        menuBacker.backgroundColor = MaterialColor.black
        menuBacker.alpha = 0
        self.x = -width
        updateFrame()
        view.backgroundColor = MySwipeVC.Constants.Color5
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureLeft))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        let swipeLeft2 = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureLeft))
        swipeLeft2.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        menuBacker.addGestureRecognizer(swipeLeft2)
    }
    
    @objc func respondToSwipeGestureLeft(){
        slideOut()
    }
    
    internal func updateFrame(){
        self.view.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    internal func slideIn(superview: UIView){
        open = true
        superview.addSubview(menuBacker)
        superview.addSubview(self.view)
        UIView.animateWithDuration(0.4, animations: {
            self.menuBacker.alpha = 0.5
            self.x = 0
            self.updateFrame()
        })
    }
    
    internal func slideOut(){
        open = false
        UIView.animateWithDuration(0.4, animations: {
            self.menuBacker.alpha = 0
            self.x = -self.width
            self.updateFrame()
            }, completion: { finished in
                self.view.removeFromSuperview()
                self.menuBacker.removeFromSuperview()
        })
    }
    
    
    



}