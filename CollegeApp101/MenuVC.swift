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
// import MainSwipeController // if using CocoaPods
class MenuVC : UIViewController, UIGestureRecognizerDelegate {

    let mainWidth = MainSwipeController.Constants.ScreenWidth
    let width = MainSwipeController.Constants.ScreenWidth * 0.7
    let height = MainSwipeController.Constants.ScreenHeight
    
    var currentSV : UIView? = nil
    
    var x : CGFloat = 0.0
    var y : CGFloat = 0.0
    
    var menuItems : [MenuItem]! = [MenuItem]()
    
    
    
    let contentStartY = 20
    
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var blurEffectView = UIVisualEffectView(effect: nil)

    var menuBacker: UIView! = UIView()
    
    let backColor = MaterialColor.grey.darken4

    
    var open = false
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    internal init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
        prepareMenuItems()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func setupView(){
        menuBacker.frame = CGRect(x: 0, y: 0, width: mainWidth, height: height)
        blurEffectView.frame = menuBacker.frame
        menuBacker.backgroundColor = MaterialColor.black
        menuBacker.alpha = 0
        self.x = -width
        updateFrame()
        view.backgroundColor = backColor
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(closeMenu))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        let swipeLeft2 = UISwipeGestureRecognizer(target: self, action: #selector(closeMenu))
        swipeLeft2.direction = UISwipeGestureRecognizerDirection.Left
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        tap.delegate = self
        self.view.addGestureRecognizer(swipeLeft)
        
        blurEffectView.addGestureRecognizer(tap)

        blurEffectView.addGestureRecognizer(swipeLeft2)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        statusBar.backgroundColor = MaterialColor.grey.darken1
        self.view.addSubview(statusBar)
        
    }
    
    
    internal func prepareMenuItems(){
        let profile = MenuItem(menu: self, title: "Profile", size: 80)
        let settings = MenuItem(menu: self, title: "Settings", size: 50)
        let logout = MenuItem(menu: self, title: "Log Out", size: 50)
        
        menuItems.append(profile)
        menuItems.append(settings)
        menuItems.append(logout)
        
        
        var lastYBot = contentStartY
        
        for item in menuItems {
            item.setYValue(lastYBot)
            lastYBot = lastYBot + item.size
            self.view.addSubview(item)
            //print(item.title)
        }
        
    }
    
    
    internal func logout(){
        slideOut()
        self.presentViewController(LoginVC(), animated: true, completion: nil)
        
    }
    internal func settings(){
        
    }
    
    
    @objc func closeMenu(){
        //UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Slide)
        //self.removeFromParentViewController()
        slideOut()
    }
    
    internal func updateFrame(){
        self.view.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    internal func slideIn(superview: UIView){
        open = true
        
        
        self.currentSV = superview
        superview.addSubview(blurEffectView)
        superview.addSubview(menuBacker)
        superview.addSubview(self.view)
        UIView.animateWithDuration(0.4, animations: {
            self.menuBacker.alpha = 0.0
            self.x = 0
            self.updateFrame()
            self.blurEffectView.effect = self.blurEffect
            self.refreshMenu()
            }, completion: { finished in
                if(finished){
                    self.refreshMenu()
                }
        })
        
    }
    
    internal func slideOut(){
        currentSV = nil
        open = false
        
        UIView.animateWithDuration(0.4, animations: {
            for item in self.menuItems {
                item.backgroundColor = self.backColor
            }
            self.menuBacker.alpha = 0
            self.x = -self.width
            self.updateFrame()
            self.blurEffectView.effect = nil
            }, completion: { finished in
                self.view.removeFromSuperview()
                self.menuBacker.removeFromSuperview()
                self.blurEffectView.removeFromSuperview()
        })
    }
    
    internal func refreshMenu(){
        blurEffectView.removeFromSuperview()
        menuBacker.removeFromSuperview()
        currentSV?.addSubview(blurEffectView)
        currentSV?.addSubview(menuBacker)
        self.view.removeFromSuperview()
        self.currentSV?.addSubview(self.view)
    }
    
    
    



}