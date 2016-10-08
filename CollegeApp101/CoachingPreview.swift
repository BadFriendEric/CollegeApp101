//
//  CoachingPreviewFreshman.swift
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

class CoachingPreview: UIViewController {
    
    let mainWidth = MainSwipeController.Constants.ScreenWidth
    let width = MainSwipeController.Constants.ScreenWidth
    let height = MainSwipeController.Constants.ScreenHeight - (MainPanels.Constants.navBarHeight + MainPanels.Constants.statusBarHeight)
    var test: FlatButton! = nil
    var superview : UIViewController! = nil
    
    var x : CGFloat = 0.0
    var y : CGFloat = 0.0
    
    let imageW = 640
    let imageH = 215
   
    
    var name = "Coaching"
    
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
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.backgroundColor = Color.green.base
        
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
        test.setTitle("Continue", for: UIControlState())
        test.setTitleColor(Color.white, for: UIControlState())
        test.backgroundColor = Color.pink.lighten3
        test.cornerRadius = 20
        test.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        mysubviews.append(test)
        
    }
    
    internal func setCoachingName(_ name: String){
        self.name = name
    }
    
    internal func setBackgroundColor(_ color : UIColor){
        self.view.backgroundColor = color
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pullUpVC(superview, dur: 0.4)
    }
    
    internal func pushDownVC(_ vc : UIViewController, dur : TimeInterval){
        self.view.frame = CGRect(x: 0.0, y: -self.height + 8, width: vc.view.frame.width, height: vc.view.frame.height)

        UIView.animate(withDuration: dur, animations: {
            
            self.view.frame = CGRect(x: 0.0, y: MainPanels.Constants.navBarHeight + MainPanels.Constants.statusBarHeight + 8, width: self.view.frame.width, height: self.view.frame.height)
            vc.view.frame = CGRect(x: 0.0, y: vc.view.frame.maxY, width: vc.view.frame.width, height: vc.view.frame.height)
            self.view.layoutIfNeeded()
            //vc.view.layoutIfNeeded()
        })
        
    }
    
    internal func pullUpVC(_ vc : UIViewController, dur : TimeInterval){
        UIView.animate(withDuration: dur, animations: {
            //let vcY : CGFloat = 0.0
            //self.view.frame = CGRect(x: 0.0, y: self.y_init, width: self.width, height: self.height)
            self.view.frame = CGRect(x: 0.0, y: -self.height + 8, width: self.view.frame.width, height: self.view.frame.height)
            vc.view.frame = CGRect(x: 0.0, y: 0.0, width: vc.view.frame.width, height: vc.view.frame.height)
            self.view.layoutIfNeeded()
            //vc.view.layoutIfNeeded()
            }, completion: { finished in
                self.view.removeFromSuperview()
        })
    }
    
    internal func setPreviewImgs(){
        var desc : UIImageView
        desc = UIImageView(frame:CGRect(x: 20, y: 80, width: imageW/2, height: imageH/2))
        desc.image = UIImage(named:"freshmanDesc")
        self.view.addSubview(desc)
        
        var before : UIImageView
        before = UIImageView(frame:CGRect(x: 20, y: 200, width: imageW/2, height: imageH/2))
        before.image = UIImage(named:"freshmanBefore")
        self.view.addSubview(before)

        var after : UIImageView
        after = UIImageView(frame:CGRect(x: 20, y: 320, width: imageW/2, height: imageH/2))
        after.image = UIImage(named:"freshmanAfter")
        self.view.addSubview(after)

    }
    
    @objc internal func handleContinueButton(){
        //Override to go to this coaching options main page
    }
    
    
}
