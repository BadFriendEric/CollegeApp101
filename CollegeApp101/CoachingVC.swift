//
//  self.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 10/5/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import Foundation
import UIKit
import Material

class CoachingVC : UIViewController, UIGestureRecognizerDelegate {
    


    var main : MainPanels! = nil
    var profile : Profile! = nil
    
    let width = MainSwipeController.Constants.ScreenWidth
    let height = MainSwipeController.Constants.ScreenHeight
    let viewHeight = MainSwipeController.Constants.ScreenHeightWithoutStatusBar - MainPanels.Constants.navBarHeight
    let h0 = MainPanels.Constants.navBarHeight
    
    var profilePic : UIImage! = UIImage()
    let profilePicView : UIImageView! = UIImageView()
    var profilePicFrame : CGRect! = CGRect()
    let profilePicMainSize = (MainSwipeController.Constants.ScreenHeightWithoutStatusBar - MainPanels.Constants.navBarHeight)/3 - 40
    
    var profileTopBacker : UIView! = UIView()
    
    let previewBacker : UIView! = UIView()
    
    let mainColor = UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.0)
    
    var cpe : CoachingPreview! = nil
    
    
    internal func prepareView(main: MainPanels){
        self.main = main
        self.profile = main.profile
        self.view.backgroundColor = Color.grey.lighten2
        preparePreviews()
        prepareProfileView()
        prepareButtonsView()
    }
    
    internal func preparePreviews(){
        previewBacker.frame = main.view.frame
        previewBacker.backgroundColor = Color.black.withAlphaComponent(0.0)

        
        cpe = CoachingPreview(superview:self)
    }
    
    internal func prepareProfileView(){
        profileTopBacker.frame = CGRect(x: 0, y: h0, width: width, height: viewHeight/3-15)
        profileTopBacker.backgroundColor = mainColor
        self.view.addSubview(profileTopBacker)
        
        profilePic = profile.getProfilePicture()
        _ = MainPanels.ResizeImage(profilePic, targetSize: CGSize(width: profilePicMainSize, height: profilePicMainSize))
        profilePicView.image = profilePic.circle
        profilePicView.frame = CGRect(x: (width-profilePicMainSize)/2, y: h0 + profilePicMainSize/4 + 25, width: profilePicMainSize, height: profilePicMainSize)
        profilePicFrame = profilePicView.frame
        self.view.addSubview(profilePicView)
        
        profilePicView.isUserInteractionEnabled = true
        let picTap = UITapGestureRecognizer(target: self, action: #selector(handlePictureTap))
        picTap.delegate = self
        profilePicView.addGestureRecognizer(picTap)
        
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: profilePicView.frame.minY-15, width: width, height: 20))
        nameLabel.text = profile.getFullName()
        nameLabel.font = RobotoFont.medium(with: 24)
        nameLabel.textAlignment = .center
        nameLabel.textColor = Color.grey.darken3
        self.view.addSubview(nameLabel)
        
        let editProfileLabel = UILabel(frame: CGRect(x: 0, y: profilePicView.frame.maxY, width: width, height: 20))
        editProfileLabel.text = "Edit Profile"
        editProfileLabel.font = RobotoFont.light(with: 18)
        editProfileLabel.textAlignment = .center
        editProfileLabel.textColor = Color.grey.base
        self.view.addSubview(editProfileLabel)
        
    }
    
    
    ///Prepare Coach Panel///
    internal func prepareButtonsView(){
        
        let coursesBacker = UIView(frame: CGRect(x: 0, y: viewHeight/2+5, width: width, height: 30))
        coursesBacker.backgroundColor = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        self.view.addSubview(coursesBacker)
        
        let coursesLabel = UILabel(frame: CGRect(x: 0, y: viewHeight/2+5, width: width, height: 30))
        coursesLabel.text = "Courses"
        coursesLabel.font = UIFont(name: "Lora-Bold", size: 26)
        coursesLabel.textAlignment = .center
        coursesLabel.textColor = Color.grey.darken3
        self.view.addSubview(coursesLabel)
        
        let buttonsBacker = UIView(frame: CGRect(x: 0, y: coursesBacker.frame.maxY, width: width, height: height-coursesBacker.frame.maxY))
        buttonsBacker.backgroundColor = mainColor
        self.view.addSubview(buttonsBacker)
        
        let crp = CornerRadiusPreset.cornerRadius4
        
        
        let series101: FlatButton = FlatButton(frame: CGRect(x: 10, y: height-viewHeight/4-10 , width: width-20, height: viewHeight/4))
        
        series101.setTitle("101 Series", for: .normal)
        series101.setTitleColor(Color.white, for: .normal)
        series101.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 32)
        series101.backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)
        series101.cornerRadiusPreset = crp
        self.view.addSubview(series101)
        
        let writing: FlatButton = FlatButton(frame: CGRect(x: 10, y: coursesBacker.frame.maxY+20 , width: (width-40)/3, height: viewHeight/5))
        writing.setTitle("Write", for: .normal)
        writing.setTitleColor(Color.white, for: .normal)
        writing.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 28)
        writing.backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)
        writing.cornerRadiusPreset = crp
        self.view.addSubview(writing)
        
        let learn: FlatButton = FlatButton(frame: CGRect(x: 20 + (width-40)/3, y: coursesBacker.frame.maxY+20 , width: (width-40)/3, height: viewHeight/5))
        learn.setTitle("Learn", for: .normal)
        learn.setTitleColor(Color.white, for: .normal)
        learn.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 28)
        learn.backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)
        learn.cornerRadiusPreset = crp
        self.view.addSubview(learn)

        let eval: FlatButton = FlatButton(frame: CGRect(x: 30 + 2*(width-40)/3, y: coursesBacker.frame.maxY+20 , width: (width-40)/3, height: viewHeight/5))
        eval.setTitle("Evaluate", for: .normal)
        eval.setTitleColor(Color.white, for: .normal)
        eval.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 24)
        eval.backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)
        eval.cornerRadiusPreset = crp
        eval.addTarget(self, action: #selector(CoachingVC.handleEval), for: .touchUpInside)
        self.view.addSubview(eval)
        
        
    }
    
    internal func handleEval(){
        showPreview(preview: cpe)
    }
    
    internal func showPreview(preview: CoachingPreview){
        main.view.addSubview(previewBacker)
        main.view.addSubview(preview.view)
        preview.pushDownVC(main, dur: 0.4)
    }
    
    internal func handlePictureTap(){
        let picSize = profilePicMainSize + 20

        UIView.animate(withDuration: 0.15, animations: {
            self.profilePicView.frame = CGRect(x: (self.width-picSize)/2, y: self.h0 + picSize/4 - 10, width: picSize, height: picSize)
            }, completion: { finished in
                UIView.animate(withDuration: 0.15, animations: {
                    self.profilePicView.frame = self.profilePicFrame
                })
                
        })
    }

    
    internal func addCircle(frame: CGRect, btn: FlatButton, c: CGColor){
        let path = UIBezierPath(ovalIn: frame)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = c
        btn.layer.addSublayer(shapeLayer)
        
    }
    
    
}
