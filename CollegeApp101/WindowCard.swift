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

class WindowCard: UIViewController {
    
    let mainWidth = MainSwipeController.Constants.ScreenWidth
    let width = MainSwipeController.Constants.ScreenWidth - 60
    let height = MainSwipeController.Constants.ScreenHeight - 120
    var test: FlatButton! = nil
    var superview : HubVC! = nil
    
    
    var x : CGFloat = 30
    var y : CGFloat = 200
    
    let imageW = 640
    let imageH = 215
    
    let exit : IconButton = IconButton()
    
    var name = "Coaching"
    
    var words: UILabel!
    var pic: UIImageView!
    
    var mysubviews = [UIView]()
    
    internal init(superview : HubVC) {                 //HOW DO WE MAKE THIS SOMETHIGN YOU CAN ADD TO ANY VIEW CONTROLLER??????
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
        
        //prepareText()
        prepareImage()
        prepareButton()
        prepareExitButton()
        reloadView()
        
    }
    
    internal func reloadView() {
        for v in mysubviews {
            v.removeFromSuperview()
            self.view.addSubview(v)
        }
    }
    
    internal func pushDownVC(_ vc : UIScrollView, dur : TimeInterval){
        self.view.frame = CGRect(x: x, y: -self.height + 8, width: self.width, height: self.height)
        UIView.animate(withDuration: dur, animations: {
            self.superview.previewBacker.backgroundColor = Color.black.withAlphaComponent(0.75)
            self.view.frame = CGRect(x: self.x + 20, y: 80, width: self.width - 40, height: self.height - 120)
        })
        
    }
    
    internal func pullUpVC(_ vc : UIScrollView, dur : TimeInterval){
        UIView.animate(withDuration: dur, animations: {
            self.view.frame = CGRect(x: self.x, y: -self.height, width: self.width, height: self.height)
            self.superview.previewBacker.backgroundColor = Color.black.withAlphaComponent(0.0)
        }, completion: { finished in
            self.view.removeFromSuperview()
            self.superview.previewBacker.removeFromSuperview()
        })
    }

    internal func prepareExitButton(){
        exit.frame = CGRect(x: self.view.frame.maxX-120, y: 5, width: 45, height: 45)
        exit.setImage(Icon.cm.close, for: UIControlState())
        exit.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        exit.tintColor = Color.white
        self.view.addSubview(exit)
    }
    
    internal func prepareButton(){
        let h : CGFloat = 80
        test = FlatButton(frame: CGRect(x: 0, y: height-h - 120, width: width - 40, height: h))
        test.setTitle("Continue", for: UIControlState())
        test.setTitleColor(Color.white, for: UIControlState())
        test.backgroundColor = Color.red.lighten1
        test.cornerRadiusPreset = CornerRadiusPreset.cornerRadius5
        test.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        mysubviews.append(test)
        
        
    }
    
    internal func prepareText(){
        words = UILabel(frame: CGRect(x: view.frame.maxX/2 - width/2, y: 10, width: width/2, height: 30))
        words.adjustsFontSizeToFitWidth = true
        words.textAlignment = .center
        words.backgroundColor = Color.yellow.base
        mysubviews.append(words)
    }
    
    internal func prepareImage(){
        
        pic = UIImageView(frame: CGRect(x: 0, y: 0, width: width-40, height: height - 120))
        pic.image = #imageLiteral(resourceName: "sampleBg")
        
        mysubviews.append(pic)
        
    }
    
    @objc internal func handleContinueButton(){
        //Override to go to this coaching options main page
    }
    
    internal func handleExit(){
        pullUpVC(superview, dur: 0.3)
    }


    
}
