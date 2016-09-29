//
//  CareerFeatureVolunteerMatch.swift
//  CollegeApp101
//
//  Created by Eric Ota on 9/24/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import Foundation
import Material
import UIKit

public class CareerFeatureVolunteerMatch: CareerFeature, UITextFieldDelegate {

    var hLine: UIView! = UIView()
    var vLine: UIView! = UIView()
    
    let imageSize = 375

    public override init() {
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func getFeatures() -> [UIView] {
        return features
    }
    
    override public func setFrame(_ x: Int, y: Int, width: Int, height: Int) {
        super.setFrame(x, y: y, width: width, height: height)
        setFeatureTitle("Volunteer Match")
        prepareMapImg()
        prepareBottomLeftBox()
        prepareBottomRightBox()
        prepareLines()
        //refreshScrollView(height)
    }

    func prepareLines(){
        let lineColor : UIColor = Color.black
        
        hLine = UIView(frame: CGRect(x: 0,y: imageSize+5,width: width,height: 2))
        hLine.layer.borderWidth = 0
        hLine.backgroundColor = lineColor
        hLine.alpha = 1
        features.append(hLine)
        
        vLine = UIView(frame: CGRect(x: width/2,y: imageSize+5,width: 2,height: 300))
        vLine.layer.borderWidth = 0
        vLine.backgroundColor = lineColor
        vLine.alpha = 1
        features.append(vLine)
    }
    
    func prepareMapImg(){
        var mapImg : UIImageView
        mapImg = UIImageView(frame:CGRect(x: 0, y: 5, width: imageSize, height: imageSize))
        mapImg.alpha = 1
        mapImg.image = UIImage(named:"appleMapImg")
        features.append(mapImg)
        
        let titleText = UILabel(frame: CGRect(x: width/2 - 150, y: 150, width: 300, height: 60))
        titleText.text = "Tap to view local \n volunteering oportunities"
        titleText.font = UIFont(name: "Poiret One", size: 30)
        titleText.textColor = Color.black
        titleText.adjustsFontSizeToFitWidth = true
        //titleText.backgroundColor = Color.grey.lighten3
        titleText.numberOfLines = 2
        titleText.backgroundColor = Color.white
        titleText.contentMode = .center
        features.append(titleText)
        
    }
    
    func prepareBottomLeftBox(){
        let leftView = FlatButton(frame: CGRect(x: 0, y: imageSize + 5, width: width/2, height: 185))
        leftView.backgroundColor = Color.purple.darken2
        leftView.setTitle("My Volunteering", for: .normal)
        leftView.titleLabel?.font = UIFont(name: "Poiret One", size: 30)
        leftView.titleLabel?.adjustsFontSizeToFitWidth = true
        leftView.titleEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        features.append(leftView)
    }
    
    func prepareBottomRightBox(){
        let rightView = FlatButton(frame: CGRect(x: width/2, y: imageSize+5, width: width/2, height: 185))
        rightView.backgroundColor = Color.red.darken2
        rightView.setTitle("How to be a good volunteer", for: .normal)
        rightView.titleLabel?.font = UIFont(name: "Poiret One", size: 30)
        rightView.titleLabel?.adjustsFontSizeToFitWidth = true
        rightView.titleEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        features.append(rightView)

    }
    //bkeh

    
}
