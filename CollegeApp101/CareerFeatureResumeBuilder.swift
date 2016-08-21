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
    let iconSize = 50
    var words: String = "Input resume item 2"
    let textBox: UITextField = UITextField()
    var textBoxSize = 50
    
    
    
    
    public override init() {
        super.init()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public override func setFrame(x: Int, y: Int, width: Int, height: Int) {  //open Resume Builder
        super.setFrame(x, y: y, width: width, height: height)
        setFeatureTitle("Resume Builder", x: width/2 - 80)
        prepareMainButtons()
        prepareTextField()
        refreshScrollView(1000) //use when pushing stuff off the screen
    }
    
  
    
    private func prepareMainButtons(){
        
        let button: FlatButton = FlatButton()
        button.frame = CGRect(x: width/2 + width/4 - 25, y: height - 50, width: 75, height: 25)
        button.setTitleColor(MaterialColor.white, forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Scope One", size: 10)
        button.setTitle("Add Card", forState: .Normal)
        button.backgroundColor = MaterialColor.amber.base
        button.addTarget(self, action: #selector(handleAddResumeCard), forControlEvents: .TouchUpInside)
        features.append(button)
        
    }

    private func prepareTextField(){
        textBox.frame = CGRect(x: 20, y: 40, width: width - 40, height: 80)
        textBox.backgroundColor = MaterialColor.white
        textBox.font = RobotoFont.medium
        
        textBox.placeholder = "Keep your accomplishments here for when you apply for college"
        features.append(textBox)
        
    }
    
    internal func handleAddResumeCard(){
        let size = 110
        words = textBox.text!
        
        addResumeCard(50, vc: self.scrollView, text: words)
        resumeCardBottom += size+resumeCardSpacing

        if(resumeCardBottom > Int(self.view.frame.height)){
            refreshScrollView(resumeCardBottom)
        }
    }
    
    internal func addResumeCard(y: Int, vc: UIScrollView, text: String){
        let card: ResumeCard = ResumeCard(vc: self, x: 25, y: 180 + 105*(resumeCards.count), width: width - 50, height: 100, text: text)
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
    
    internal func deleteResumeCard(card: ResumeCard){
        /* 
        card.removeFromSuperview()
        resumeCards.removeAtIndex(resumeCards.indexOf(card)!)
        refreshResumeCards()
         */
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textBox.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textBox.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        (textField as? ErrorTextField)?.revealError = false
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }



    
}