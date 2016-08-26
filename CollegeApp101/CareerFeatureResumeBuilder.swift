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

public class CareerFeatureResumeBuilder: CareerFeature, UITextViewDelegate {
    
    var resumeCards: [ResumeCard] = []
    private var resumeCardSpacing = 25
    private var resumeCardBottom = 50
    let iconSize = 50
    var words: String = "vibes"
    var timeWords: String = "chill"
    let placeHolder = "Name of activity"
    let placeHolderTime = "ex: 3 hours per week"
    let textBox: UITextView = UITextView()
    let timeText: UITextView = UITextView()
    var textBoxSize = 50
    let button: FlatButton = FlatButton()

    public override init() {
        super.init()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public override func setFrame(x: Int, y: Int, width: Int, height: Int) {  //open Resume Builder
        super.setFrame(x, y: y, width: width, height: height)
        setFeatureTitle("Resume Builder")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tap.delegate = self
        scrollView.addGestureRecognizer(tap)
        prepareMainButtons()
        prepareTextField()
        prepareTimeText()
        refreshScrollView(1000) //use when pushing stuff off the screen
    }
    
  
    
    private func prepareMainButtons(){
        button.frame = CGRect(x: width/2 + width/4 - 25, y: 100, width: 75, height: 25)
        button.setTitleColor(MaterialColor.white, forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Scope One", size: 10)
        button.setTitle("Add Card", forState: .Normal)
        button.backgroundColor = MaterialColor.grey.base
        button.addTarget(self, action: #selector(handleAddResumeCard), forControlEvents: .TouchUpInside)
        features.append(button)
        
    }
    
    private func prepareTextField(){
        textBox.frame = CGRect(x: 20, y: 10, width: width - 40, height: 80)
        textBox.delegate = self
        textBox.backgroundColor = MaterialColor.white
        textBox.font = RobotoFont.lightWithSize(16)
        textBox.textColor = MaterialColor.grey.lighten1
        textBox.text! = placeHolder
        textBox.layer.cornerRadius = 10
        features.append(textBox)
        
    }
    
    private func prepareTimeText(){
        timeText.frame = CGRect(x: 20, y: 100, width: width - 150, height: 30)
        timeText.delegate = self
        timeText.backgroundColor = MaterialColor.white
        timeText.font = RobotoFont.lightWithSize(16)
        timeText.textColor = MaterialColor.grey.lighten1
        timeText.text! = placeHolderTime
        timeText.layer.cornerRadius = 10
        features.append(timeText)

    }
    
    internal func handleAddResumeCard(){
        let size = 110
        if button.backgroundColor == MaterialColor.amber.base{
            words = textBox.text!
            timeWords = timeText.text!
            textBox.textColor = MaterialColor.grey.lighten1
            timeText.textColor = MaterialColor.grey.lighten1
            textBox.text = placeHolder
            timeText.text = placeHolderTime
            textBox.resignFirstResponder()
            timeText.resignFirstResponder()
            addResumeCard(50, vc: self.scrollView, text: words)
            resumeCardBottom += size+resumeCardSpacing
        }
        else{
            textBox.textColor = MaterialColor.grey.lighten1
            timeText.textColor = MaterialColor.grey.lighten1
            textBox.text = placeHolder
            timeText.text = placeHolderTime
            textBox.resignFirstResponder()
            timeText.resignFirstResponder()
            //ADD POPUP HERE

        }

        if(resumeCardBottom > Int(self.view.frame.height)){
            refreshScrollView(resumeCardBottom)
        }
    }
    
    internal func addResumeCard(y: Int, vc: UIScrollView, text: String){
        let card: ResumeCard = ResumeCard(vc: self, x: 25, y: 180 + 110*(resumeCards.count), width: width - 50, height: 100, text: text, text2: timeWords)
        button.backgroundColor = MaterialColor.grey.base
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
    
    
    func backgroundTapped(){
        if (textBox.text != "" && timeText.text != "" && textBox.text != placeHolder && timeText.text != placeHolderTime){
            button.backgroundColor = MaterialColor.amber.base
        }
        else{
            button.backgroundColor = MaterialColor.grey.base
        }
        textBox.resignFirstResponder()
        timeText.resignFirstResponder()
    }
    
    public func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textView.textColor == MaterialColor.grey.lighten1{
            textView.text! = ""
            textView.textColor = MaterialColor.black
        }
        return true
    }
    
    public func textViewDidEndEditing(textView: UITextView) {
        if textView.text == ""{
            textView.textColor = MaterialColor.grey.lighten1
            textBox.text = placeHolder
            timeText.text = placeHolderTime
        }
        
        if (textBox.text != "" && timeText.text != "" && textBox.text != placeHolder && timeText.text != placeHolderTime){
            button.backgroundColor = MaterialColor.amber.base
        }
    }
    
    

}




    /*
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textBox.resignFirstResponder()
    }
    
    
    func textViewShouldReturn(textView: UITextView) -> Bool {
        textBox.resignFirstResponder()
        return true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        textBox.text = ""
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textBox.text = ""
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        if( textBox.text == ""){
            textBox.text = "Keep your accomplishments here for when you apply for college"
        }
        return true
    }
    
    func textViewDidEndEditing(textField: UITextField) {
        (textField as? ErrorTextField)?.revealError = false
    }
    
    func textViewShouldClear(textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }
    
    func textView(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }


 */