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
    let buttonWidth: Int = 75
    let buildBtn: FlatButton = FlatButton()
    let buildBtnWidth: Int = 100
    let adviceBtn: FlatButton = FlatButton()
    var coachingLineMid: UIView! = UIView()
    
    public override init() {
        super.init()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func setFrame(_ x: Int, y: Int, width: Int, height: Int) {  //open Resume Builder
        super.setFrame(x, y: y, width: width, height: height)
        setFeatureTitle("Resume Builder")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tap.delegate = self
        scrollView.addGestureRecognizer(tap)
        prepareMainButtons()
        prepareBuildButton()
        prepareAdviceButton()
        prepareTextField()
        prepareRandomUI()
        prepareTimeText()
        refreshScrollView(600) //use when pushing stuff off the screen
    }
    
    
    
    private func prepareMainButtons(){
        button.frame = CGRect(x: width/2 + width/4 - 25, y: 100, width: buttonWidth, height: 25)
        button.setTitleColor(Color.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Scope One", size: 10)
        button.setTitle("Add Card", for: .normal)
        button.backgroundColor = Color.grey.base
        button.pulseColor = Color.red.darken4
        button.addTarget(self, action: #selector(handleAddResumeCard), for: .touchUpInside)
        features.append(button)
        
    }
    
    private func prepareBuildButton(){
        buildBtn.frame = CGRect(x: 40, y: 140, width: buildBtnWidth, height: 30)
        buildBtn.setTitleColor(Color.white, for: .normal)
        buildBtn.titleLabel?.font = UIFont(name: "Scope One", size: 10)
        buildBtn.setTitle("Build Resume", for: .normal)
        buildBtn.backgroundColor = Color.orange.darken2
        buildBtn.pulseColor = Color.red.darken4
        buildBtn.addTarget(self, action: #selector(handleBuildBtn), for: .touchUpInside)
        features.append(buildBtn)
    }
    
    private func prepareRandomUI(){
        //nothuing here rn lol
    }
    
    private func prepareAdviceButton(){
        adviceBtn.frame = CGRect(x: width - 210, y: 140, width: 170, height: 30)
        adviceBtn.setTitleColor(Color.white, for: .normal)
        adviceBtn.titleLabel?.font = UIFont(name: "Scope One", size: 10)
        adviceBtn.setTitle("How to improve your resume", for: .normal)
        adviceBtn.backgroundColor = Color.orange.darken2
        adviceBtn.pulseColor = Color.red.darken4
        adviceBtn.addTarget(self, action: #selector(handleHowToBtn), for: .touchUpInside)
        features.append(adviceBtn)
    }
    
    
    
    private func prepareTextField(){
        textBox.frame = CGRect(x: 20, y: 10, width: width - 40, height: 80)
        textBox.delegate = self
        textBox.backgroundColor = Color.white
        textBox.font = RobotoFont.light(with: 16)
        textBox.textColor = Color.grey.lighten1
        textBox.text! = placeHolder
        textBox.layer.cornerRadius = 10
        //textBox.clearsOnInsertion = true
        features.append(textBox)
        
    }
    
    private func prepareTimeText(){
        timeText.frame = CGRect(x: 20, y: 100, width: width - 150, height: 30)
        timeText.delegate = self
        timeText.backgroundColor = Color.white
        timeText.font = RobotoFont.light(with: 16)
        timeText.textColor = Color.grey.lighten1
        timeText.text! = placeHolderTime
        timeText.layer.cornerRadius = 10
        //timeText.clearsOnInsertion = true
        features.append(timeText)
        
    }
    
    internal func handleAddResumeCard(){
        let size = 110
        
        if textBox.hasText && timeText.hasText && button.backgroundColor == Color.grey.base{
            button.backgroundColor = Color.amber.base
            textBox.resignFirstResponder()
            timeText.resignFirstResponder()
        }
        else if button.backgroundColor == Color.amber.base{
            words = textBox.text!
            timeWords = timeText.text!
            textBox.textColor = Color.grey.lighten1
            timeText.textColor = Color.grey.lighten1
            textBox.text = placeHolder
            timeText.text = placeHolderTime
            textBox.resignFirstResponder()
            timeText.resignFirstResponder()
            addResumeCard(y: 50, vc: self.scrollView, text: words)
            resumeCardBottom += size+resumeCardSpacing
        }
        else{
            textBox.textColor = Color.grey.lighten1
            timeText.textColor = Color.grey.lighten1
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
    
    internal func handleBuildBtn(){
        //build resume items into resume
    }
    
    internal func handleHowToBtn(){
        //build resume items into resume
    }
    
    
    internal func addResumeCard(y: Int, vc: UIScrollView, text: String){
        let card: ResumeCard = ResumeCard(vc: self, x: 25, y: 180 + 110*(resumeCards.count), width: width - 50, height: 100, text: text, text2: timeWords)
        button.backgroundColor = Color.grey.base
        resumeCards.append(card)
        vc.addSubview(card)
        
    }
    
    internal func refreshResumeCards(){
        //print("refresh")
        var currentCardPos = 70 //was nav bar heigth
        for card in resumeCards{
            if(Int(card.y) > currentCardPos){
                UIView.animate(withDuration: 0.3, animations: {
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
        card.removeFromSuperview()
        resumeCards.remove(at: resumeCards.index(of: card)!)
        refreshResumeCards()
        
    }
    
    
    func backgroundTapped(){
        if (textBox.hasText && textBox.text != placeHolder && timeText.hasText && timeText.text != placeHolderTime){
            button.backgroundColor = Color.amber.base
        }
        else{
            button.backgroundColor = Color.grey.base
        }
        textBox.resignFirstResponder()
        timeText.resignFirstResponder()
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == Color.grey.lighten1{
            textView.text! = ""
            textView.textColor = Color.black
        }
        
        if textBox.hasText && timeText.hasText{
            button.backgroundColor = Color.amber.base
        }
        
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if !textView.hasText{
            textView.textColor = Color.grey.lighten1
            textBox.text = placeHolder
            timeText.text = placeHolderTime
        }
        
        if (!textBox.hasText && !timeText.hasText && textBox.text != placeHolder && timeText.text != placeHolderTime){
            button.backgroundColor = Color.amber.base
        }
    }
    
    
    
}
