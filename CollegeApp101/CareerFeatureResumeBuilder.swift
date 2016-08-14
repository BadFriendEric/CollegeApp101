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
    
    var resumeCards: [ResumeCard] = []

    
    public override init() {
        super.init()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public override func setFrame(x: Int, y: Int, width: Int, height: Int) {
        super.setFrame(x, y: y, width: width, height: height)
        setFeatureTitle("Resume Builder", x: width/2 - 80)
        prepareMainButtons()
    }
    
    private func prepareMainButtons(){
        
        let button: FlatButton = FlatButton()
        button.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        button.backgroundColor = MaterialColor.amber.base
        button.addTarget(self, action: #selector(handleAddResumeCard), forControlEvents: .TouchUpInside)
        features.append(button)
        
    }

    
    internal func handleAddResumeCard(){
        
        
        
    }
    
    internal func addResumeCard(y: Int, size: Int, vc: UIScrollView){
        let card: ResumeCard = ResumeCard(vc: self, x: 100, y: 100, width: 100, height: 100)
        resumeCards.append(card)
        vc.addSubview(card)
        
        
    }
    
    public override func getFeatures() -> [UIView] {
        return features
    }
    
}