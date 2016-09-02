//
//  CareerFeature.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 8/5/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Foundation
import Material

public class CareerFeature : UIViewController, UIGestureRecognizerDelegate {
    
    var featureLabel: UILabel! = UILabel()
    var titleLine: UIView! = UIView()
    var superView: UIView! = UIView()
    
    var features: [UIView]! = [UIView]()
    
    var featureColor: UIColor! = MaterialColor.clear
    
    var exitButton: IconButton! = IconButton()
    var exitImage: UIImage! = MaterialIcon.close
    
    var titlePane : UIView! = UIView()
    
    var expanded = false
    
    var expandable = true
    
    //Title location variables
    var x_init = 0
    var y_init = 0
    var width_init = 0
    var height_init = 0
    var title_y_init = 40
    
    var x = 0
    var y = 0
    var width = 0
    var height = 0
    var title_x = 0
    var title_y = 40
    
    //Back blur tools
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
    var blurEffectView = UIVisualEffectView(effect: nil)
    
    let title_line_width_from_edge = 20
    
    var myVC : MainPanels! = nil
    
    var scrollView : UIScrollView = UIScrollView()
    
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
        //prepareExitButton()
        prepareTitleLine()
        prepareTitlePane()
        self.scrollView.frame = CGRect(x: x, y: Int(titleLine.frame.maxY), width: width, height: height-Int(titleLine.frame.maxY))
        self.features = getFeatures()
        prepareFeatures()
    }
    
    public func updateFrame(){
        self.view.frame = CGRect(x: x, y: y, width: width, height: height)
        self.featureLabel.frame = CGRect(x: title_x, y: title_y, width: self.width, height: 20)
        self.titleLine.frame = CGRect(x: title_line_width_from_edge,y: title_y + 25,width: width - 2*title_line_width_from_edge,height: 1)
        self.titlePane.frame = CGRect(x: 0, y: 0, width: width, height: Int(titleLine.frame.maxY))
        self.scrollView.frame = CGRect(x: CGFloat(x), y: CGFloat(titleLine.frame.maxY), width: CGFloat(width), height: CGFloat(height)-titleLine.frame.maxY)
    }
    
    
    public func setColor(c: UIColor!){
        self.featureColor = c
        self.view.backgroundColor = c
    }
    public func superView(sv: UIView){
        self.superView = sv
    }
    internal func myVC(mvc : MainPanels){
        self.myVC = mvc
    }
    public func prepareTitlePane(){
        titlePane.frame = CGRect(x: 0, y: 0, width: width, height: Int(titleLine.frame.maxY))
        //titlePane.backgroundColor = featureColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTitleTap))
        tap.delegate = self
        titlePane.addGestureRecognizer(tap)
        
    }
    public func addTitlePane(){
        featureLabel.removeFromSuperview()
        titlePane.addSubview(featureLabel)
        titleLine.removeFromSuperview()
        titlePane.addSubview(titleLine)
        //titlePane.backgroundColor = featureColor
        view.addSubview(titlePane)
    }
    public func removeTitlePane(){
        featureLabel.removeFromSuperview()
        titleLine.removeFromSuperview()
        view.addSubview(featureLabel)
        view.addSubview(titleLine)
        titlePane.removeFromSuperview()
    }

    
    public func setFeatureTitle(name: String){
        title_x = 0
        featureLabel = UILabel(frame: CGRect(x: title_x, y: title_y_init, width: width, height: 20))
        featureLabel.text = name
        featureLabel.textAlignment = NSTextAlignment.Center
        featureLabel.numberOfLines = 1
        featureLabel.font = UIFont(name: "Scope One", size: 24)
        featureLabel.adjustsFontSizeToFitWidth = true
        featureLabel.lineBreakMode = .ByWordWrapping
        featureLabel.textColor = MaterialColor.white
        self.view.addSubview(featureLabel)
    }
    public func prepareTitleLine(){
        titleLine = UIView(frame: CGRect(x: title_line_width_from_edge,y: title_y_init + 25,width: width - 2*title_line_width_from_edge,height: 1))
        titleLine.layer.borderWidth = 1.0
        titleLine.layer.borderColor = UIColor.whiteColor().CGColor
        titleLine.alpha = 0
        self.view.addSubview(titleLine)
    }
    public func refreshScrollView(height: Int){
        UIView.animateWithDuration(0.3, animations: {
            self.scrollView.contentSize.height = CGFloat(height)
        })
        scrollView.clipsToBounds = true
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
        if(!expandable){
            return()
        }
        for n in 0..<myVC.careerFeatures.count {
            let cf = myVC.careerFeatures[n]
            cf.expandable = false
            if(cf.expanded){
              cf.retract()
            }
            
        }
        superView.backgroundColor = UIColor.grayColor()
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        
        blurEffectView.frame = self.view.frame
        superView.addSubview(blurEffectView)
        self.view.removeFromSuperview()
        blurEffectView.addSubview(self.view)
        
        prepareFeatures()
        expanded = true
        self.view.removeFromSuperview()
        superView.addSubview(self.view)
        let newHeight = Int(superView.frame.height)
        UIView.animateWithDuration(0.5, animations: {
            self.y = 0
            self.height = newHeight
            self.view.backgroundColor = self.featureColor.colorWithAlphaComponent(0.8)
            self.title_y = 20
            self.titleLine.alpha = 1.0
            self.updateFrame()
            self.blurEffectView.frame = self.view.frame
            }, completion: { finished in
                self.enableFeatures()
        })
        self.enableFeatures()
        self.addTitlePane()
    }
    
    public func retract(){
        expanded = false
        
        disableFeatures()
        removeTitlePane()
        
    }
    
    public func getFeatures() -> [UIView]{
        return [UIView]()
    }
    public func prepareFeatures(){
        for f in features {
            f.alpha = 0
        }
    }
    
    public func enableFeatures(){
        for f in features {
            scrollView.addSubview(f)
        }
        view.addSubview(scrollView)
        var a: CGFloat = 0.0
        UIView.animateWithDuration(0.7, animations: {
            a = 1.0
            for f in self.features {
                f.alpha = a
            }
            }, completion: { finished in
                self.addTitlePane()
        })
    }
    
    public func disableFeatures(){
        
        let newHeight = self.height_init
        UIView.animateWithDuration(0.4, animations: {
            for f in self.features {
                f.alpha = 0
            }
            self.titleLine.alpha = 0
            self.y = self.y_init
            self.height = newHeight
            self.title_y = self.title_y_init
            self.view.backgroundColor = self.featureColor
            self.updateFrame()
            self.blurEffectView.frame = self.view.frame
            
        }, completion: { finished in
            for f in self.features {
                f.removeFromSuperview()
                
            }
            self.scrollView.removeFromSuperview()
            self.view.removeFromSuperview()
            self.superView.addSubview(self.view)
            self.blurEffectView.removeFromSuperview()
            
            for n in 0..<self.myVC.careerFeatures.count {
                let cf = self.myVC.careerFeatures[n]
                cf.expandable = true
            }

        })
        
        
        
    }
    
    func handleTitleTap(){
        retract()
    }

    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    
    
}