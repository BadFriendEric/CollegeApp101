//
//  CoachingPreviewSenior.swift
//  CollegeApp101
//
//  Created by Eric Ota on 8/10/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//
//
//  CoachingPreviewGeneral.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 8/9/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Material

class CoachingPreviewSenior : UIViewController {
    
    let mainWidth = EZSwipeController.Constants.ScreenWidth
    let width = EZSwipeController.Constants.ScreenWidth
    let height = EZSwipeController.Constants.ScreenHeight
    var test: FlatButton! = nil
    var superview : UIViewController! = nil
    
    var x : CGFloat = 0.0
    var y : CGFloat = -EZSwipeController.Constants.ScreenHeight
    
    let name = "Senior"
    
    var mysubviews = [UIView]()
    
    internal init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    internal func setupView(){
        y = -height + MySwipeVC.Constants.navBarHeightWithStatusBar
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.backgroundColor = MaterialColor.red.lighten2
        
        prepareButton()
        reloadView()
        
    }
    internal func reloadView() {
        for v in mysubviews {
            v.removeFromSuperview()
            self.view.addSubview(v)
        }
    }
    
    internal func prepareButton(){
        test = FlatButton(frame: CGRect(x: (width-150)/2, y: height-100, width: 150, height: 60))
        test.setTitle("Continue", forState: .Normal)
        test.setTitleColor(MaterialColor.white, forState: .Normal)
        test.backgroundColor = MaterialColor.red.base
        test.addTarget(self, action: #selector(handleContinueButton), forControlEvents: .TouchUpInside)
        mysubviews.append(test)
        
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pullUpVC(superview, dur: 0.4)
    }
    
    internal func pushDownVC(vc : UIViewController, dur : NSTimeInterval){
        UIView.animateWithDuration(dur, animations: {
            let vcY = self.height
            vc.view.frame = CGRect(x: 0.0, y: vcY, width: vc.view.frame.width, height: vc.view.frame.height)
            self.view.frame = CGRect(x: 0.0, y: MySwipeVC.Constants.navBarHeightWithStatusBar, width: vc.view.frame.width, height: vc.view.frame.height)
        })
    }
    
    internal func pullUpVC(vc : UIViewController, dur : NSTimeInterval){
        UIView.animateWithDuration(dur, animations: {
            //let vcY : CGFloat = 0.0
            vc.view.frame = CGRect(x: 0.0, y: 0.0, width: vc.view.frame.width, height: vc.view.frame.height)
            self.view.frame = CGRect(x: 0.0, y: -self.height + MySwipeVC.Constants.navBarHeightWithStatusBar, width: vc.view.frame.width, height: vc.view.frame.height)
        })
    }
    
    @objc internal func handleContinueButton(){
        //Override to go to this coaching options main page
    }
    
    
}