//
//  CoachingPreviewWriting.swift
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

class CoachingPreviewWriting : UIViewController {
    
    let mainWidth = MainSwipeController.Constants.ScreenWidth
    let width = MainSwipeController.Constants.ScreenWidth
    let height = MainSwipeController.Constants.ScreenHeight
    var test: FlatButton! = nil
    var superview : UIViewController! = nil
    
    var x : CGFloat = 0.0
    var y : CGFloat = -MainSwipeController.Constants.ScreenHeight
    
    let name = "Writing"
    
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
        y = -height + MainPanels.Constants.navBarHeightWithStatusBar
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.backgroundColor = MaterialColor.cyan.base  //changed
        
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
        test = FlatButton(frame: CGRect(x: (width-150)/2, y: height-170, width: 150, height: 60))
        test.setTitle("Continue", forState: .Normal)
        test.setTitleColor(MaterialColor.white, forState: .Normal)
        test.backgroundColor = MaterialColor.red.base
        test.addTarget(self, action: #selector(handleContinueButton), forControlEvents: .TouchUpInside)
        mysubviews.append(test)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pullUpVC(superview, dur: 0.4)
    }
    
    internal func pushDownVC(vc : UIViewController, dur : NSTimeInterval){
        UIView.animateWithDuration(dur, animations: {
            let vcY = self.height
            vc.view.frame = CGRect(x: 0.0, y: vcY, width: vc.view.frame.width, height: vc.view.frame.height)
            self.view.frame = CGRect(x: 0.0, y: 0.0 + MainPanels.Constants.navBarHeightWithStatusBar, width: vc.view.frame.width, height: vc.view.frame.height)
        })
    }
    
    internal func pullUpVC(vc : UIViewController, dur : NSTimeInterval){
        UIView.animateWithDuration(dur, animations: {
            //let vcY : CGFloat = 0.0
            vc.view.frame = CGRect(x: 0.0, y: 0.0, width: vc.view.frame.width, height: vc.view.frame.height)
            self.view.frame = CGRect(x: 0.0, y: -self.height + MainPanels.Constants.navBarHeightWithStatusBar, width: vc.view.frame.width, height: vc.view.frame.height)
        })
    }
    
    @objc internal func handleContinueButton(){
        //Override to go to this coaching options main page
    }
    
    
}