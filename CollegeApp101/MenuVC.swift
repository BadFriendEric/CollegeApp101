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
    
    var x : CGFloat = 0.0
    var y : CGFloat = 0.0
    
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var blurEffectView = UIVisualEffectView(effect: nil)

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
        blurEffectView.frame = menuBacker.frame
        menuBacker.backgroundColor = MaterialColor.black
        menuBacker.alpha = 0
        self.x = -width
        updateFrame()
        view.backgroundColor = MaterialColor.grey.darken4
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(closeMenu))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        let swipeLeft2 = UISwipeGestureRecognizer(target: self, action: #selector(closeMenu))
        swipeLeft2.direction = UISwipeGestureRecognizerDirection.Left
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        tap.delegate = self
        self.view.addGestureRecognizer(swipeLeft)
        
        blurEffectView.addGestureRecognizer(tap)

        blurEffectView.addGestureRecognizer(swipeLeft2)
    }
    
    @objc func closeMenu(){
        slideOut()
    }
    
    internal func updateFrame(){
        self.view.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    internal func slideIn(superview: UIView){
        open = true
        superview.addSubview(blurEffectView)
        superview.addSubview(menuBacker)
        superview.addSubview(self.view)
        UIView.animateWithDuration(0.4, animations: {
            self.menuBacker.alpha = 0.0
            self.x = 0
            self.updateFrame()
            self.blurEffectView.effect = self.blurEffect
        })
        
    }
    
    internal func slideOut(){
        open = false
        UIView.animateWithDuration(0.4, animations: {
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
    
    
    



}