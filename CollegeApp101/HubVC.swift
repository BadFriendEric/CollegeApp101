//
//  hubVC.swift
//  CollegeApp101
//
//  Created by Eric Ota on 1/15/17.
//  Copyright © 2017 CollegeApp101. All rights reserved.
//

import Foundation
import UIKit
import Material

class HubVC : UIScrollView, UIGestureRecognizerDelegate {
    
    var main : MainPanels! = nil
    var profile : Profile! = nil
    
    //Screen variables
    //let width = MainSwipeController.Constants.ScreenWidth
    //let height = MainSwipeController.Constants.ScreenHeight
    let viewHeight = MainSwipeController.Constants.ScreenHeight - MainPanels.Constants.navBarHeight
    let h0 = MainPanels.Constants.navBarHeight
    let mainColor = UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.0)
    
    //Profile views and variables
    
    var profilePic : UIImage! = UIImage()
    let profilePicView : UIImageView! = UIImageView()
    var profilePicFrame : CGRect! = CGRect()
    let profilePicMainSize = (MainSwipeController.Constants.ScreenHeight - MainPanels.Constants.navBarHeight)/3 - 100
    var profileTopBacker : UIView! = UIView()
    let nameLabel = UILabel()
    let editProfileLabel = UILabel()
    
    //Timeline variables ////////////////////////////////////////////////////////////////////
    
    var arrowBtn: UIButton!
    let arrowH: CGFloat = 40.0
    let arrowW: CGFloat = 80.0
    let timelineH: CGFloat = 285
    
    var addTimeline: UIButton!
    
    var timelineText: UILabel!
    var timelineLabel: String!
    
    /////////////////////////////////////////////////////////////////////////////////////////

    //Preview variables
    var previewBacker : UIView! = UIView()
    var addWindow : WindowCard! = nil

    
    
    internal func prepareView(main: MainPanels){
        self.main = main
        self.profile = main.profile
        self.superview?.backgroundColor = Color.grey.lighten2
        preparePreviews()
        prepareProfileView()
        prepareTimeline()
    }
    
    internal func prepareProfileView(){
        
        //contentSize = CGSize(width: 200, height: 400)
        
        profileTopBacker.frame = CGRect(x: 0, y: h0, width: width, height: viewHeight/3-15)
        profileTopBacker.backgroundColor = mainColor
        self.addSubview(profileTopBacker)
        
        profilePic = profile.getProfilePicture()
        _ = MainPanels.ResizeImage(profilePic, targetSize: CGSize(width: profilePicMainSize, height: profilePicMainSize))
        profilePicView.image = profilePic.circle
        profilePicView.frame = CGRect(x: (width-profilePicMainSize)/2, y: h0 + profilePicMainSize/4 + 25, width: profilePicMainSize, height: profilePicMainSize)
        profilePicFrame = profilePicView.frame
        self.addSubview(profilePicView)
        
        profilePicView.isUserInteractionEnabled = true
        let picTap = UITapGestureRecognizer(target: self, action: #selector(handlePictureTap))
        picTap.delegate = self
        profilePicView.addGestureRecognizer(picTap)
        
        
        nameLabel.frame = CGRect(x: 0, y: profilePicView.frame.minY-15, width: width, height: 20)
        nameLabel.text = profile.getFullName()
        nameLabel.font = RobotoFont.medium(with: 24)
        nameLabel.textAlignment = .center
        nameLabel.textColor = Color.grey.darken3
        self.addSubview(nameLabel)
        
        editProfileLabel.frame = CGRect(x: 0, y: profilePicView.frame.maxY, width: width, height: 20)
        editProfileLabel.text = "Edit Profile"
        editProfileLabel.font = RobotoFont.light(with: 18)
        editProfileLabel.textAlignment = .center
        editProfileLabel.textColor = Color.grey.base
        self.addSubview(editProfileLabel)
        
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
    
    func prepareTimeline(){
        let firstX: CGFloat = 20.0
        arrowBtn = UIButton(frame: CGRect(x: firstX, y: timelineH, width: arrowW, height: arrowH))
        arrowBtn.backgroundColor = Color.cyan.lighten1
        arrowBtn.setTitle("Test", for: .normal)
        arrowBtn.cornerRadius = 10
        self.addSubview(arrowBtn)

        addTimeline = UIButton(frame: CGRect(x: firstX + 90, y: timelineH + arrowH/2 - 20, width: 40, height: 40))
        addTimeline.imageEdgeInsets = .zero
        addTimeline.backgroundColor = Color.teal.lighten1
        addTimeline.cornerRadius = 15
        addTimeline.setImage(Icon.add, for: .normal)
        addTimeline.addTarget(self, action: #selector(handleArrowPressed), for: .touchUpInside)
        self.addSubview(addTimeline)
        
        timelineLabel = "Your next deadline is in 56 days"
        timelineText = UILabel(frame: CGRect(x: 30, y: 235, width: self.width - 60, height: 40.0))
        timelineText.backgroundColor = Color.blue.accent2
        timelineText.text = timelineLabel
        timelineText.textAlignment = .center
        timelineText.adjustsFontSizeToFitWidth = true
        timelineText.alpha = 0.7
        self.addSubview(timelineText)
        
        
        
    }
    
    internal func preparePreviews(){
        previewBacker.frame = main.view.frame
        previewBacker.backgroundColor = Color.black.withAlphaComponent(0.0)
        
        
        addWindow = WindowCard(superview: self)
    }

    
    internal func showPreview(preview: WindowCard){
        main.view.addSubview(previewBacker)
        main.view.addSubview(preview.view)
        preview.pushDownVC(self, dur: 0.3)
    }


    func handleArrowPressed(){
        showPreview(preview: addWindow)
        print("Yee")
    }
    
}
