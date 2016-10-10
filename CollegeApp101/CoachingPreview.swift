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
    let width = MainSwipeController.Constants.ScreenWidth - 30
    let height = MainSwipeController.Constants.ScreenHeight - 50
    var test: FlatButton! = nil
    var superview : CoachingVC! = nil
    
    var x : CGFloat = 15
    var y : CGFloat = 25
    
    let imageW = 640
    let imageH = 215
    
    let exit : IconButton = IconButton()
    
    var name = "Coaching"
    
    var mysubviews = [UIView]()
    
    internal init(superview : CoachingVC) {
        super.init(nibName: nil, bundle: nil)
        self.superview = superview
        setupView()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    internal func setupView(){
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.backgroundColor = Color.white
        self.view.cornerRadiusPreset = CornerRadiusPreset.cornerRadius5
                
        prepareExitButton()
        prepareButton()
        reloadView()
        
    }
    internal func reloadView() {
        for v in mysubviews {
            v.removeFromSuperview()
            self.view.addSubview(v)
        }
    }
    
    internal func prepareExitButton(){
        exit.frame = CGRect(x: self.view.frame.maxX-60, y: 5, width: 45, height: 45)
        exit.setImage(Icon.cm.close, for: UIControlState())
        exit.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        exit.tintColor = Color.black
        self.view.addSubview(exit)
    }
    
    internal func prepareButton(){
        let h : CGFloat = 100
        test = FlatButton(frame: CGRect(x: 0, y: height-h, width: width, height: h))
        test.setTitle("Continue", for: UIControlState())
        test.setTitleColor(Color.white, for: UIControlState())
        test.backgroundColor = Color.red.lighten1
        test.cornerRadiusPreset = CornerRadiusPreset.cornerRadius5
        test.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        mysubviews.append(test)
        
        
    }
    
    internal func setCoachingName(_ name: String){
        self.name = name
    }
    
    internal func setBackgroundColor(_ color : UIColor){
        self.view.backgroundColor = color
    }
    
    internal func handleExit(){
        pullUpVC(superview, dur: 0.4)

    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    internal func pushDownVC(_ vc : UIViewController, dur : TimeInterval){
        self.view.frame = CGRect(x: x, y: -self.height + 8, width: self.width, height: self.height)
        UIView.animate(withDuration: dur, animations: {
            self.superview.previewBacker.backgroundColor = Color.black.withAlphaComponent(0.75)
            self.view.frame = CGRect(x: self.x, y: 20, width: self.width, height: self.height)
        })
        
    }
    
    internal func pullUpVC(_ vc : UIViewController, dur : TimeInterval){
        UIView.animate(withDuration: dur, animations: {
            self.view.frame = CGRect(x: self.x, y: -self.height, width: self.width, height: self.height)
            self.superview.previewBacker.backgroundColor = Color.black.withAlphaComponent(0.0)
            }, completion: { finished in
                self.view.removeFromSuperview()
                self.superview.previewBacker.removeFromSuperview()
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
