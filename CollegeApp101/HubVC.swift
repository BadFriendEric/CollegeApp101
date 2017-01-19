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
    let timelineH: CGFloat = 280.0
    
    /////////////////////////////////////////////////////////////////////////////////////////
    
    
    internal func prepareView(main: MainPanels){
        self.main = main
        self.profile = main.profile
        self.superview?.backgroundColor = Color.grey.lighten2
        //preparePreviews()
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
        
        arrowBtn.backgroundColor = Color.amber.base
        arrowBtn.setTitle("Test", for: .normal)
        arrowBtn.addTarget(self, action: #selector(handleArrowPressed), for: .touchUpInside)
        
        self.addSubview(arrowBtn)
        
        
    }

    func handleArrowPressed(){
        print("yee")
        
    }
    
}
