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

    
    private func addCard(){
        
        let card: HubCard = HubCard(vc: self,type: "Reminder",x: 20, y: y, width: Int(Constants.ScreenWidth-40),height: size)
        hubCards.append(card)
        vc.addSubview(card)

        
    }
    
    
}