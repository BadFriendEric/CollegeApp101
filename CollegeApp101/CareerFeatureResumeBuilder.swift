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
    private var resumeCardSpacing = 25
    private var resumeCardBottom = 50
    
    
    public override init() {
        super.init()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public override func setFrame(x: Int, y: Int, width: Int, height: Int) {
        super.setFrame(x, y: y, width: width, height: height)
        setFeatureTitle("Resume Builder", x: width/2 - 80)
        refreshScrollView(1000) //use when pushing stuff off the screen
        prepareMainButtons()
    }
    
    private func prepareMainButtons(){
        
        let button: FlatButton = FlatButton()
        button.frame = CGRect(x: width/2 + 20, y: 50, width: 75, height: 25)
        button.setTitleColor(MaterialColor.white, forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Scope One", size: 10)
        button.setTitle("Add Card", forState: .Normal)
        button.backgroundColor = MaterialColor.amber.base
        button.addTarget(self, action: #selector(handleAddResumeCard), forControlEvents: .TouchUpInside)
        features.append(button)
        
    }

    
    internal func handleAddResumeCard(){
        let size = 110

        addResumeCard(50, vc: self.scrollView)
        resumeCardBottom += size+resumeCardSpacing

        if(resumeCardBottom > Int(self.view.frame.height)){
            refreshScrollView(resumeCardBottom)
        }
    }
    
    internal func addResumeCard(y: Int, vc: UIScrollView){
        let card: ResumeCard = ResumeCard(vc: self, x: 0 + 15, y: 140 + 100*(resumeCards.count), width: width - 30, height: 100)
        resumeCards.append(card)
        vc.addSubview(card)
        
        

        
    }
    
    internal func refreshResumeCards(){
        //print("refresh")
        var currentCardPos = 70 //was nav bar height
        for card in resumeCards{
            if(Int(card.y) > currentCardPos){
                UIView.animateWithDuration(0.3, animations: {
                    card.y = CGFloat(currentCardPos)
                })
            }
            currentCardPos = Int(card.y) + Int(card.height) + resumeCardSpacing
        }
        if(resumeCards.isEmpty){
            resumeCardBottom = 70 //was nav bar height
        }else{
            resumeCardBottom = Int((resumeCards.last?.y)!) + Int((resumeCards.last?.height)!) + resumeCardSpacing
        }
        self.refreshScrollView(self.resumeCardBottom)
    }

    
    public override func getFeatures() -> [UIView] {
        return features
    }
    
}