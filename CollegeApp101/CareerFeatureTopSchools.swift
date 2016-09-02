//
//  CareerFeatureTopSchools.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 8/10/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Foundation
import Material

public class CareerFeatureTopSchools : CareerFeature {
    
    
    public override init() {
        super.init()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func setFrame(x: Int, y: Int, width: Int, height: Int) {
        super.setFrame(x, y: y, width: width, height: height)
        setFeatureTitle("Top Schools")
        refreshScrollView(height)
    }
    
        public override func updateFrame(){
        super.updateFrame()
    }
    
    public override func getFeatures() -> [UIView] {
        return features
    }
    
    
    
    
    
    
}