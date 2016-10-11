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
    
    //Screen variables
    let width = MainSwipeController.Constants.ScreenWidth
    let height = MainSwipeController.Constants.ScreenHeight
    let viewHeight = MainSwipeController.Constants.ScreenHeight - MainPanels.Constants.navBarHeight
    let h0 = MainPanels.Constants.navBarHeight
    let mainColor = UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.0)
    
    //Profile views and variables
    
    var profilePic : UIImage! = UIImage()
    let profilePicView : UIImageView! = UIImageView()
    var profilePicFrame : CGRect! = CGRect()
    let profilePicMainSize = (MainSwipeController.Constants.ScreenHeight - MainPanels.Constants.navBarHeight)/3 - 40
    var profileTopBacker : UIView! = UIView()
    let nameLabel = UILabel()
    let editProfileLabel = UILabel()
    
    
    //Coaching button views
    var coachingViews : [UIView] = [UIView]()
    let coursesBacker = UIView()
    let coursesLabel = UILabel()
    let buttonsBacker = UIView()
    let series101: FlatButton = FlatButton()
    let writing: FlatButton = FlatButton()
    let learn: FlatButton = FlatButton()
    let eval: FlatButton = FlatButton()
    
    //Preview variables
    let previewBacker : UIView! = UIView()
    var cpe : CoachingPreview! = nil
    
    //Searching screen variables
    var counter = 0
    let scale : Double = 10
    let numBalls = 20
    let BALL_HEIGHT : Double = 12
    var balls : [CAShapeLayer] = [CAShapeLayer]()
    
    var timer : Timer = Timer()
    
    
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
        
        
        nameLabel.frame = CGRect(x: 0, y: profilePicView.frame.minY-15, width: width, height: 20)
        nameLabel.text = profile.getFullName()
        nameLabel.font = RobotoFont.medium(with: 24)
        nameLabel.textAlignment = .center
        nameLabel.textColor = Color.grey.darken3
        self.view.addSubview(nameLabel)
        
        editProfileLabel.frame = CGRect(x: 0, y: profilePicView.frame.maxY, width: width, height: 20)
        editProfileLabel.text = "Edit Profile"
        editProfileLabel.font = RobotoFont.light(with: 18)
        editProfileLabel.textAlignment = .center
        editProfileLabel.textColor = Color.grey.base
        self.view.addSubview(editProfileLabel)
        
    }
    
    
    ///Prepare Coach Panel///
    internal func prepareButtonsView(){
        
        coursesBacker.frame = CGRect(x: 0, y: viewHeight/2+5, width: width, height: 30)
        coursesBacker.backgroundColor = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        self.view.addSubview(coursesBacker)
        coachingViews.append(coursesBacker)
        
        coursesLabel.frame = CGRect(x: 0, y: viewHeight/2+5, width: width, height: 30)
        coursesLabel.text = "Courses"
        coursesLabel.font = UIFont(name: "Lora-Bold", size: 26)
        coursesLabel.textAlignment = .center
        coursesLabel.textColor = Color.grey.darken3
        self.view.addSubview(coursesLabel)
        coachingViews.append(coursesLabel)
        
        buttonsBacker.frame = CGRect(x: 0, y: coursesBacker.frame.maxY, width: width, height: height-coursesBacker.frame.maxY)
        buttonsBacker.backgroundColor = mainColor
        self.view.addSubview(buttonsBacker)
        coachingViews.append(buttonsBacker)
        
        let crp = CornerRadiusPreset.cornerRadius4
        
        
        series101.frame = CGRect(x: 10, y: height-viewHeight/4-10 , width: width-20, height: viewHeight/4)
        
        series101.setTitle("101 Series", for: .normal)
        series101.setTitleColor(Color.white, for: .normal)
        series101.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 32)
        series101.backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)
        series101.cornerRadiusPreset = crp
        series101
            .addTarget(self, action: #selector(CoachingVC.handle101), for: .touchUpInside)
        self.view.addSubview(series101)
        coachingViews.append(series101)
        
        writing.frame = CGRect(x: 10, y: coursesBacker.frame.maxY+20 , width: (width-40)/3, height: viewHeight/5)
        writing.setTitle("Write", for: .normal)
        writing.setTitleColor(Color.white, for: .normal)
        writing.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 28)
        writing.backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)
        writing.cornerRadiusPreset = crp
        self.view.addSubview(writing)
        coachingViews.append(writing)
        
        learn.frame = CGRect(x: 20 + (width-40)/3, y: coursesBacker.frame.maxY+20 , width: (width-40)/3, height: viewHeight/5)
        learn.setTitle("Learn", for: .normal)
        learn.setTitleColor(Color.white, for: .normal)
        learn.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 28)
        learn.backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)
        learn.cornerRadiusPreset = crp
        self.view.addSubview(learn)
        coachingViews.append(learn)

        eval.frame = CGRect(x: 30 + 2*(width-40)/3, y: coursesBacker.frame.maxY+20 , width: (width-40)/3, height: viewHeight/5)
        eval.setTitle("Evaluate", for: .normal)
        eval.setTitleColor(Color.white, for: .normal)
        eval.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 24)
        eval.backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)
        eval.cornerRadiusPreset = crp
        eval.addTarget(self, action: #selector(CoachingVC.handleEval), for: .touchUpInside)
        self.view.addSubview(eval)
        coachingViews.append(eval)
        
        
    }
    
    internal func handleEval(){
        showPreview(preview: cpe)
    }
    
    internal func handle101(){
        startSearching()
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
        
        returnToLobby()
    }

    
    internal func addCircle(frame: CGRect, btn: FlatButton, c: CGColor){
        let path = UIBezierPath(ovalIn: frame)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = c
        btn.layer.addSublayer(shapeLayer)
        
    }
    
    internal func startSearching(){
        UIView.animate(withDuration: 0.6, animations: {
            for i in self.coachingViews{
                i.alpha = 0
            }
            self.editProfileLabel.alpha = 0
            
        }, completion:{ finished in
            
            for i in self.coachingViews{
                i.removeFromSuperview()
            }
            self.editProfileLabel.removeFromSuperview()
        })
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: .curveEaseIn, animations: {
            self.profileTopBacker.frame = CGRect(x: 0, y: self.h0, width: self.width, height: self.viewHeight)
            }, completion: { finished in
                self.prepareBalls(numBalls: self.numBalls)
        })
        
        
        
        
        
    }
    
    
    func updateBalls() {
        DispatchQueue.global(qos: .background).async {
            
            
            
            
            //print("test")
            
            self.counter += 15
            DispatchQueue.main.async {
                
                for i in 0..<self.balls.count {
                    let b = self.balls[i]
                    b.frame = CGRect(x: b.frame.minX, y: CGFloat(self.getBallY(i: i, t: self.counter)), width: b.frame.width, height: b.frame.height)
                }
                //print("Test2")
            }
        }

    }
    
    internal func returnToLobby(){
        
        timer.invalidate()
        
        for i in self.coachingViews{
            view.addSubview(i)
        }
        view.addSubview(editProfileLabel)
        
        UIView.animate(withDuration: 0.6, animations: {
            
            self.profileTopBacker.frame = CGRect(x: 0, y: self.h0, width: self.width, height: self.viewHeight/3-15)
            }, completion:{ finished in
                
        })
        for b in self.balls {
            b.removeFromSuperlayer()
        }
        balls.removeAll()
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: .curveEaseIn, animations: {
            for i in self.coachingViews{
                i.alpha = 1
            }
            self.editProfileLabel.alpha = 1
            }, completion: { finished in
                
        })
        
    }
    
    internal func prepareBalls(numBalls : Int){
        let w = width - 20
        let w1 = 5 + (w / CGFloat(numBalls))
        for i in (0..<numBalls){
            let dot = CAShapeLayer()
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: 10 + w1*CGFloat(i),y: self.viewHeight/2), radius: CGFloat(BALL_HEIGHT/2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
            
            dot.path = circlePath.cgPath
            //dot.lineWidth = 2
            //dot.strokeColor = Color.white.cgColor
            dot.fillColor = Color.purple.darken1.cgColor
            //dot.zPosition = 11
            self.balls.append(dot)
        }
        for b in balls {
            self.view.layer.addSublayer(b)
        }
        counter = 0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(CoachingVC.updateBalls), userInfo: nil, repeats: true)
    }
    
    internal func getBallY(i : Int, t: Int) -> Int{
        
        let s1 = sin(Double(t) * (Double(i)/500.0 + 0.02))
        let p2 = (2*Double.pi)
        
        
        let s2 = remainder(s1, p2)
        
        return Int((scale*(BALL_HEIGHT/2 * (1 + s2))))
    }
    
    
}
