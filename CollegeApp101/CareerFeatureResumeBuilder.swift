//
//  CareerFeatureResumeBuilder.swift
//  CollegeApp101
//
//  Created by Eric Ota on 8/13/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import Foundation
import Material
import UIKit

public class CareerFeatureResumeBuilder: CareerFeature{
    
    var plannerScrollView : UIScrollView! = UIScrollView()

    
    public override init() {
        super.init()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public override func setFrame(x: Int, y: Int, width: Int, height: Int) {
        super.setFrame(x, y: y, width: width, height: height)
        plannerScrollView.frame = CGRect(x: x, y: title_y_init, width: width, height: height-title_y_init)
        setFeatureTitle("Resume Builder", x: width/2 - 40)
        prepareMainButtons()
    }
    
    private func prepareMainButtons(){
        
        
        
    }

    
}