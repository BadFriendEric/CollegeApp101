//
//  TopSchoolsListItem.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 9/1/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import Foundation
import UIKit
import Material

class TopSchoolsListItem : UIView {
    
    
    var schoolName : String = ""
    var feature : CareerFeatureTopSchools? = nil
    var itemNumber = 0
    let h = CGFloat(60)
    
    internal init(schoolName : String, feature : CareerFeatureTopSchools){
        super.init(frame: CGRect(x: 0, y: 0, width: Int(MainSwipeController.Constants.ScreenWidth), height: Int(h)))
        self.schoolName = schoolName
        self.feature = feature
    }
    
    internal func setYPosition(_ y : Int){
        frame = CGRect(x: 0, y: y, width: Int(MainSwipeController.Constants.ScreenWidth), height: Int(h))
    }
    
    internal func prepareTitleLabel(){
        let l = UILabel(frame: CGRect(x: 0, y: 15, width: frame.width, height: 30))
        l.text = schoolName
        l.textColor = Color.white
        l.font = RobotoFont.bold(with: 18)
        self.addSubview(l)
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
