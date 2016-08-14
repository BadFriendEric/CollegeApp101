//
//  CoachingFeature.swift
//  CollegeApp101
//
//  Created by Eric Ota on 8/9/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Foundation
import Material

public class CoachingFeature : UIViewController {
    
    var featureLabel: UILabel! = UILabel()
    var titleLine: UIView! = UIView()
    var superView: UIView! = UIView()
    
    var features: [UIView]! = [UIView]()
    
    var featureColor: UIColor! = MaterialColor.amber.base
    
    var exitButton: IconButton! = IconButton()
    var exitImage: UIImage! = MaterialIcon.close
    
    var expanded = false
    
    var x_init = 0
    var y_init = 0
    var width_init = 0
    var height_init = 0
    var title_y_init = 40
    
    var x = 0
    var y = 0
    var width = 0
    var height = 0
    var title_y = 40
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //Just initialize a frame
    public func setupView(){
        self.view.frame = CGRectZero
    }
    
    public func updateFrame(){
        self.view.frame = CGRect(x: x, y: y, width: width, height: height)
        self.featureLabel.frame = CGRect(x: self.width/2 - 70, y: title_y, width: self.width, height: 40)
        self.titleLine.frame = CGRect(x: 40,y: title_y + 40,width: width - 80,height: 1)
    }
    
    //Most of the variable setting will happen in this function because this code is sloppy
    public func setFrame(x: Int, y: Int, width: Int, height: Int) {
        self.view.frame = CGRect(x: x, y: y, width: width, height: height)
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.x_init = x
        self.y_init = y
        self.width_init = width
        self.height_init = height
        self.view.backgroundColor = featureColor
        prepareExitButton()
        prepareTitleLine()
        self.features = getFeatures()
        prepareFeatures()
    }
    public func setColor(c: UIColor!){
        self.featureColor = c
        self.view.backgroundColor = c
    }
    public func superView(sv: UIView){
        self.superView = sv
    }
    
    
    public func setFeatureTitle(name: String){
        featureLabel = UILabel(frame: CGRect(x: width/2 - 70, y: title_y_init, width: width, height: 40))
        featureLabel.text = name
        featureLabel.numberOfLines = 1
        featureLabel.font = RobotoFont.mediumWithSize(20)
        featureLabel.adjustsFontSizeToFitWidth = true
        featureLabel.lineBreakMode = .ByWordWrapping
        featureLabel.textColor = MaterialColor.white
        self.view.addSubview(featureLabel)
    }
 
    public func prepareTitleLine(){
        titleLine = UIView(frame: CGRect(x: 40,y: title_y_init + 40,width: width - 80,height: 1))
        titleLine.layer.borderWidth = 1.0
        titleLine.layer.borderColor = UIColor.whiteColor().CGColor
        titleLine.alpha = 0
        self.view.addSubview(titleLine)
    }
    
 
    
    public func prepareExitButton(){
        exitButton = IconButton(frame: CGRect(x: width-45, y: 0, width: 50, height: 35))
        exitButton.pulseColor = MaterialColor.white
        exitButton.tintColor = MaterialColor.black
        exitButton.setImage(exitImage, forState: .Normal)
        exitButton.setImage(exitImage, forState: .Highlighted)
        exitButton.addTarget(self, action: #selector(handleExitButton), forControlEvents: .TouchUpInside)
    }
    internal func handleExitButton(){
        retract()
        
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if expanded {
            //retract()
        }else{
            expand()
        }
        
    }
    
    public func expand(){
        expanded = true
        self.view.removeFromSuperview()
        
        superView.addSubview(self.view)
        let newHeight = Int(superView.frame.height)
        UIView.animateWithDuration(0.5, animations: {
            self.y = 0
            self.height = newHeight
            self.view.backgroundColor = self.featureColor
            self.title_y = 5
            self.titleLine.alpha = 1.0
            self.updateFrame()
            }, completion: { finished in
                self.enableFeatures()
                self.exitButton.alpha = 0.0
                UIView.animateWithDuration(0.4, animations: {
                    self.exitButton.alpha = 1.0
                    self.exitButton.removeFromSuperview()
                    self.view.addSubview(self.exitButton)
                    
                })
                
                //self.view.removeFromSuperview()
                //self.superView.addSubview(self.view)
        })
        self.enableFeatures()
    }
    
    public func retract(){
        expanded = false
        disableFeatures()
        
    }
    
    public func getFeatures() -> [UIView]{
        
        var f = [UIView]()
        
        let l = UILabel(frame: CGRect(x: width/2 - 70, y: title_y + 50, width: width/2, height: 40))
        l.text = "this is feature stuff right here oh yeah yeah it is"
        l.numberOfLines = 2
        l.font = RobotoFont.mediumWithSize(14)
        l.adjustsFontSizeToFitWidth = true
        l.lineBreakMode = .ByWordWrapping
        l.textColor = MaterialColor.white
        f.append(l)
        
        return f
    }
    public func prepareFeatures(){
        for f in features {
            f.alpha = 0
        }
    }
    
    public func enableFeatures(){
        for f in features {
            view.addSubview(f)
        }
        var a: CGFloat = 0.0
        UIView.animateWithDuration(0.7, animations: {
            a = 1.0
            for f in self.features {
                f.alpha = a
            }
            }, completion: { finished in
                
        })
    }
    
    public func disableFeatures(){
        var a: CGFloat = 1.0
        let newHeight = self.height_init
        UIView.animateWithDuration(0.4, animations: {
            a = 0.0
            for f in self.features {
                f.alpha = a
            }
            
            self.exitButton.alpha = 0
            self.titleLine.alpha = 0
            self.y = self.y_init
            self.height = newHeight
            self.title_y = self.title_y_init
            self.updateFrame()
            
            
            }, completion: { finished in
                for f in self.features {
                    f.removeFromSuperview()
                }
                self.exitButton.removeFromSuperview()
                
                
                //UIView.animateWithDuration(0.4, animations: {
                //                    }, completion: { finished in
                //})
        })
        
        
    }
    
    

    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
}