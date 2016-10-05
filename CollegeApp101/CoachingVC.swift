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

class CoachingVC : UIViewController {
    
    var coachingPreviewGeneral : CoachingPreview! = CoachingPreview()
    var coachingPreviewWriting : CoachingPreview! = CoachingPreview()
    var coachingPreviewEvaluation : CoachingPreview! = CoachingPreview()
    var coachingPreviewFreshman : CoachingPreview! = CoachingPreview()
    var coachingPreviewSophomore : CoachingPreview! = CoachingPreview()
    var coachingPreviewJunior : CoachingPreview! = CoachingPreview()
    var coachingPreviewSenior : CoachingPreview! = CoachingPreview()

    var main : MainPanels! = nil
    var profile : Profile! = nil
    
    let width = MainSwipeController.Constants.ScreenWidth
    let height = MainSwipeController.Constants.ScreenHeight
    let viewHeight = MainSwipeController.Constants.ScreenHeightWithoutStatusBar - MainPanels.Constants.navBarHeight
    let h0 = MainPanels.Constants.navBarHeight
    
    var profileTopBacker : UIView! = UIView()
    
    internal func prepareView(main: MainPanels){
        self.main = main
        self.profile = main.profile
        self.view.backgroundColor = Color.grey.lighten2
        prepareProfileView()
        //prepareButtonsView()
    }
    
    internal func prepareProfileView(){
        profileTopBacker.frame = CGRect(x: 0, y: h0, width: width, height: viewHeight/3-20)
        profileTopBacker.backgroundColor = Color.blue.darken4
        self.view.addSubview(profileTopBacker)
        
        let profilePic = profile.getProfilePicture()
        let picSize = viewHeight/3-25
        _ = MainPanels.ResizeImage(profilePic, targetSize: CGSize(width: picSize, height: picSize))
        let profilePicView : UIImageView = UIImageView(image: profilePic.circle)
        profilePicView.frame = CGRect(x: (width-picSize)/2, y: h0 + picSize/4 + 10, width: picSize, height: picSize)
        self.view.addSubview(profilePicView)
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: profilePicView.frame.maxY-5, width: width, height: 20))
        nameLabel.text = profile.getFullName()
        nameLabel.font = RobotoFont.medium(with: 24)
        nameLabel.textAlignment = .center
        nameLabel.textColor = Color.grey.darken3
        self.view.addSubview(nameLabel)
        
        let editProfileLabel = UILabel(frame: CGRect(x: 0, y: profilePicView.frame.maxY+20, width: width, height: 20))
        editProfileLabel.text = "Edit Profile"
        editProfileLabel.font = RobotoFont.light(with: 18)
        editProfileLabel.textAlignment = .center
        editProfileLabel.textColor = Color.grey.base
        self.view.addSubview(editProfileLabel)
        
    }
    
    
    ///Prepare Coach Panel///
    internal func prepareButtonsView(){
        
        
        coachingPreviewGeneral.superview = self
        coachingPreviewWriting.superview = self
        coachingPreviewEvaluation.superview = self
        coachingPreviewFreshman.superview = self
        coachingPreviewSophomore.superview = self
        coachingPreviewJunior.superview = self
        coachingPreviewSenior.superview  = self
        
        let freshmanColor = UIColor(red:0.79, green:0.95, blue:0.98, alpha:1.0)
        let sophomoreColor = UIColor(red:0.43, green:0.85, blue:0.96, alpha:1.0)
        let juniorColor = UIColor(red:0.01, green:0.76, blue:0.92, alpha:1.0)
        let seniorColor = UIColor(red:0.00, green:0.59, blue:0.73, alpha:1.0)
        let writingColor = UIColor(red:0.87, green:0.91, blue:0.78, alpha:1.0)
        let generalColor = UIColor(red:0.73, green:0.81, blue:0.50, alpha:1.0)
        let evaluationColor = UIColor(red:0.59, green:0.76, blue:0.18, alpha:1.0)
        
        //let backgroundColor = UIColor(red:0.82, green:0.92, blue:0.91, alpha:1.0)
        
        coachingPreviewGeneral.setCoachingName("General")
        coachingPreviewWriting.setCoachingName("Writing")
        coachingPreviewEvaluation.setCoachingName("Evaluation")
        coachingPreviewFreshman.setCoachingName("Freshman")
        coachingPreviewSophomore.setCoachingName("Sophomore")
        coachingPreviewJunior.setCoachingName("Junior")
        coachingPreviewSenior.setCoachingName("Senior")
        
        
        coachingPreviewGeneral.setBackgroundColor(generalColor)
        coachingPreviewWriting.setBackgroundColor(writingColor)
        coachingPreviewEvaluation.setBackgroundColor(evaluationColor)
        coachingPreviewFreshman.setBackgroundColor(freshmanColor)
        coachingPreviewSophomore.setBackgroundColor(sophomoreColor)
        coachingPreviewJunior.setBackgroundColor(juniorColor)
        coachingPreviewSenior.setBackgroundColor(seniorColor)
        
        coachingPreviewFreshman.setPreviewImgs()
        
        let titleColor: UIColor! = Color.black
        
        
        let h = self.view.frame.height - 70
        //CGRect(x: 0, y: 70, width: self.view.frame.width/2, height: h/3)
        let writing: FlatButton = FlatButton(frame: CGRect(x: 0, y: 70, width: self.view.frame.width/2, height: h/3))
        addCircle(frame: CGRect(x: 5, y: 10, width: self.view.frame.width/2 - 10, height: self.view.frame.width/2 - 10), btn: writing, c: writingColor.cgColor)
        writing.setTitleColor(titleColor, for: UIControlState())
        writing.setTitle("Writing", for: UIControlState())
        writing.cornerRadius = 0
        writing.titleLabel?.font = UIFont(name: "Scope One", size: 30)
        writing.titleLabel?.adjustsFontSizeToFitWidth = true
        //writing.backgroundColor = Color.red.lighten1
        //writing.backgroundColor Color.amber.base
        writing.addTarget(self, action: #selector(handleCoachingWritingButton), for: .touchDown)
        self.view.addSubview(writing)
        
        let general: FlatButton = FlatButton(frame: CGRect(x: 0, y: 70 + h/3, width: self.view.frame.width/2, height: h/3))
        addCircle(frame: CGRect(x: 5, y: 10, width: self.view.frame.width/2 - 10, height: self.view.frame.width/2 - 10), btn: general, c: generalColor.cgColor)
        general.setTitleColor(titleColor, for: UIControlState())
        general.setTitle("General", for: UIControlState())
        //general.backgroundColor Color.amber.base
        general.cornerRadius = 0
        general.titleLabel?.font = UIFont(name: "Scope One", size: 30)
        general.titleLabel?.adjustsFontSizeToFitWidth = true
        general.addTarget(self, action: #selector(handleCoachingGeneralButton), for: .touchDown)
        self.view.addSubview(general)
        
        let evaluation: FlatButton = FlatButton(frame: CGRect(x: 0, y: 70 + 2*(h/3), width: self.view.frame.width/2, height: h/3))
        addCircle(frame: CGRect(x: 5, y: 10, width: self.view.frame.width/2 - 10, height: self.view.frame.width/2 - 10), btn: evaluation, c: evaluationColor.cgColor)
        evaluation.setTitleColor(titleColor, for: UIControlState())
        evaluation.setTitle("Evaluation", for: UIControlState())
        evaluation.cornerRadius = 0
        evaluation.titleLabel?.font = UIFont(name: "Scope One", size: 30)
        evaluation.titleLabel?.adjustsFontSizeToFitWidth = true
        //evaluation.backgroundColor Color.amber.base
        evaluation.addTarget(self, action: #selector(handleCoachingEvaluationButton), for: .touchDown)
        self.view.addSubview(evaluation)
        
        let freshman: FlatButton = FlatButton(frame: CGRect(x: self.view.frame.width/2, y: 70, width: self.view.frame.width/2, height: h/4))
        addCircle(frame: CGRect(x: 20, y: 5, width: self.view.frame.width/2 - 40, height: self.view.frame.width/2 - 50), btn: freshman, c: freshmanColor.cgColor)
        freshman.setTitleColor(titleColor, for: UIControlState())
        freshman.setTitle("Freshman", for: UIControlState())
        freshman.titleLabel?.font = UIFont(name: "Scope One", size: 26)
        freshman.titleLabel?.adjustsFontSizeToFitWidth = false
        freshman.cornerRadius = 0
        //freshman.backgroundColor = Color.purple.lighten2
        //freshman.backgroundColor Color.amber.base
        freshman.addTarget(self, action: #selector(handleCoachingFreshmanButton), for: .touchDown)
        self.view.addSubview(freshman)
        
        let sophomore: FlatButton = FlatButton(frame: CGRect(x: self.view.frame.width/2, y: 70 + (h/4), width: self.view.frame.width/2, height: h/4))
        addCircle(frame: CGRect(x: 20, y: 5, width: self.view.frame.width/2 - 40, height: self.view.frame.width/2 - 50), btn: sophomore, c: sophomoreColor.cgColor)
        sophomore.setTitleColor(titleColor, for: UIControlState())
        sophomore.setTitle("Sophomore", for: UIControlState())
        sophomore.titleLabel?.font = UIFont(name: "Scope One", size: 26)
        sophomore.titleLabel?.adjustsFontSizeToFitWidth = false
        sophomore.cornerRadius = 0
        //sophomore.backgroundColor = Color.teal.lighten2
        //sophomore.backgroundColor Color.amber.base
        sophomore.addTarget(self, action: #selector(handleCoachingSophomoreButton), for: .touchDown)
        self.view.addSubview(sophomore)
        
        let junior: FlatButton = FlatButton(frame: CGRect(x: self.view.frame.width/2, y: 70 + 2*(h/4), width: self.view.frame.width/2, height: h/4))
        addCircle(frame: CGRect(x: 20, y: 5, width: self.view.frame.width/2 - 40, height: self.view.frame.width/2 - 50), btn: junior, c: juniorColor.cgColor)
        junior.setTitleColor(titleColor, for: UIControlState())
        junior.setTitle("Junior", for: UIControlState())
        junior.cornerRadius = 0
        junior.titleLabel?.font = UIFont(name: "Scope One", size: 26)
        junior.titleLabel?.adjustsFontSizeToFitWidth = false
        //junior.backgroundColor = Color.pink.lighten2
        //junior.backgroundColor Color.amber.base
        junior.addTarget(self, action: #selector(handleCoachingJuniorButton), for: .touchDown)
        self.view.addSubview(junior)
        
        let senior: FlatButton = FlatButton(frame: CGRect(x: self.view.frame.width/2, y: 70 + 3*(h/4), width: self.view.frame.width/2, height: h/4))
        addCircle(frame: CGRect(x: 20, y: 5, width: self.view.frame.width/2 - 40, height: self.view.frame.width/2 - 50), btn: senior, c: seniorColor.cgColor)
        senior.titleLabel?.font = UIFont(name: "Scope One", size: 26)
        senior.titleLabel?.adjustsFontSizeToFitWidth = false
        senior.setTitleColor(titleColor, for: UIControlState())
        senior.setTitle("Senior", for: UIControlState())
        senior.cornerRadius = 0
        //senior.backgroundColor = Color.cyan.lighten2
        //senior.backgroundColor Color.amber.base
        senior.addTarget(self, action: #selector(handleCoachingSeniorButton), for: .touchDown)
        self.view.addSubview(senior)
        
        
        
    }
    
    @objc fileprivate func handleCoachingGeneralButton(){
        view.addSubview(coachingPreviewGeneral.view)
        main.refreshNavBar()
        coachingPreviewGeneral.pushDownVC(self, dur: 0.5)
        //self.addChildViewController(self)
    }
    
    @objc fileprivate func handleCoachingWritingButton(){
        view.addSubview(coachingPreviewWriting.view)  //Change to writing
        main.refreshNavBar()
        coachingPreviewWriting.pushDownVC(self, dur: 0.5)  //writing
    }
    
    @objc fileprivate func handleCoachingEvaluationButton(){
        view.addSubview(coachingPreviewEvaluation.view)  //Change to evaluation
        main.refreshNavBar()
        coachingPreviewEvaluation.pushDownVC(self, dur: 0.5)  //evaluation
    }
    
    @objc fileprivate func handleCoachingFreshmanButton(){
        view.addSubview(coachingPreviewFreshman.view)  //Change to freshman
        main.refreshNavBar()
        coachingPreviewFreshman.pushDownVC(self, dur: 0.5)  //evaluation
    }
    
    @objc fileprivate func handleCoachingSophomoreButton(){
        view.addSubview(coachingPreviewSophomore.view)  //Change to sophomiore lol lololool (lol -sam)
        main.refreshNavBar()
        coachingPreviewSophomore.pushDownVC(self, dur: 0.5)  //evaluation
    }
    
    @objc fileprivate func handleCoachingJuniorButton(){
        view.addSubview(coachingPreviewJunior.view)  //Change to freshman
        main.refreshNavBar()
        coachingPreviewJunior.pushDownVC(self, dur: 0.5)  //evaluation
    }
    
    @objc fileprivate func handleCoachingSeniorButton(){
        view.addSubview(coachingPreviewSenior.view)  //Change to freshman
        main.refreshNavBar()
        
        coachingPreviewSenior.pushDownVC(self, dur: 0.5)  //evaluation
    }

    
    internal func addCircle(frame: CGRect, btn: FlatButton, c: CGColor){
        let path = UIBezierPath(ovalIn: frame)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = c
        btn.layer.addSublayer(shapeLayer)
        
    }
    
    
}
