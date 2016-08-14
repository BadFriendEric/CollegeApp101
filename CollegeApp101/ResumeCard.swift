//
//  ResumeCard.swift
//  
//
//  Created by Eric Ota on 8/13/16.
//
//

import Foundation
import UIKit
import Material

class ResumeCard: CardView{
    
    var view: CareerFeatureResumeBuilder = CareerFeatureResumeBuilder()

    internal init(vc: CareerFeatureResumeBuilder, x: Int, y: Int, width: Int, height: Int){
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.view = vc
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        
    
}