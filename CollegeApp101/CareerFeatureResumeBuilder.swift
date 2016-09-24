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

public class CareerFeatureResumeBuilder: CareerFeature, UITextFieldDelegate {
    
    var resumeCards: [ResumeCard] = []
    private var resumeCardSpacing = 25
    private var resumeCardBottom = 50
    let iconSize = 50
    var words: String = "vibes"
    var timeWords: String = "chill"
    var titleWords: String = "jesus"
    let placeHolder = "Short description of your involvement"
    let placeHolderTime = "How often (ex: 3 hours per week)"
    let placeHolderTitle = "Name of activity"
    let textBox: UITextField = UITextField()
    let timeText: UITextField = UITextField()
    let titleText: UITextField = UITextField()
    var textBoxSize = 50
    let button: FlatButton = FlatButton()
    let buttonWidth: Int = 95
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
        prepareTitleText()
        refreshScrollView(600) //use when pushing stuff off the screen
    }
    
    
    
    private func prepareMainButtons(){
        button.frame = CGRect(x: width/2 + width/4 - 20, y: 10, width: buttonWidth, height: buttonWidth - 35)
        button.setTitleColor(Color.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Scope One", size: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitle("Add Card", for: .normal)
        button.backgroundColor = Color.grey.base
        button.pulseColor = Color.grey.lighten4
        button.addTarget(self, action: #selector(handleAddResumeCard), for: .touchUpInside)
        features.append(button)
        
    }
    
    private func prepareBuildButton(){
        buildBtn.frame = CGRect(x: 40, y: 150, width: buildBtnWidth, height: 30)
        buildBtn.setTitleColor(Color.white, for: .normal)
        buildBtn.titleLabel?.font = UIFont(name: "Scope One", size: 20)
        buildBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        buildBtn.setTitle("Build Resume", for: .normal)
        buildBtn.backgroundColor = Color.purple.darken2
        buildBtn.pulseColor = Color.grey.lighten4
        buildBtn.addTarget(self, action: #selector(handleBuildBtn), for: .touchUpInside)
        features.append(buildBtn)
    }
    
    private func prepareRandomUI(){
        //nothuing here rn lol
    }
    
    private func prepareAdviceButton(){
        adviceBtn.frame = CGRect(x: width - 210, y: 150, width: 170, height: 30)
        adviceBtn.setTitleColor(Color.white, for: .normal)
        adviceBtn.titleLabel?.font = UIFont(name: "Scope One", size: 20)
        adviceBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        adviceBtn.setTitle("How to improve your resume", for: .normal)
        adviceBtn.backgroundColor = Color.purple.darken2
        adviceBtn.pulseColor = Color.grey.lighten4
        adviceBtn.addTarget(self, action: #selector(handleHowToBtn), for: .touchUpInside)
        features.append(adviceBtn)
    }
    
    private func prepareTitleText(){
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: titleText.height))
        titleText.leftView = paddingView
        titleText.leftViewMode = UITextFieldViewMode.always
        
        titleText.frame = CGRect(x: 20, y: 10, width: width - 140, height: 30)
        titleText.delegate = self
        titleText.backgroundColor = Color.white
        titleText.font = RobotoFont.light(with: 16)
        titleText.textColor = Color.grey.lighten1
        titleText.text! = placeHolderTitle
        titleText.layer.cornerRadius = 10
        //titleText.clearsOnInsertion = true
        titleText.clearButtonMode = .whileEditing
        titleText.returnKeyType = .done
        features.append(titleText)
        
    }

    private func prepareTimeText(){
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: timeText.height))
        timeText.leftView = paddingView
        timeText.leftViewMode = UITextFieldViewMode.always
        
        timeText.frame = CGRect(x: 20, y: 45, width: width - 140, height: 30)
        timeText.delegate = self
        timeText.backgroundColor = Color.white
        timeText.font = RobotoFont.light(with: 16)
        timeText.textColor = Color.grey.lighten1
        timeText.text! = placeHolderTime
        timeText.layer.cornerRadius = 10
        //timeText.clearsOnInsertion = true
        timeText.clearButtonMode = .whileEditing
        timeText.returnKeyType = .done
        features.append(timeText)
        
    }

    private func prepareTextField(){
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: textBox.height))
        textBox.leftView = paddingView
        textBox.leftViewMode = UITextFieldViewMode.always

        textBox.frame = CGRect(x: 20, y: 80, width: width - 40, height: 60)
        textBox.delegate = self
        textBox.backgroundColor = Color.white
        textBox.font = RobotoFont.light(with: 16)
        textBox.textColor = Color.grey.lighten1
        textBox.text! = placeHolder
        textBox.layer.cornerRadius = 10
        textBox.textAlignment = .left
        textBox.contentVerticalAlignment = .top
        //textBox.clearsOnInsertion = true
        textBox.clearButtonMode = .whileEditing
        textBox.returnKeyType = .done
        features.append(textBox)
        
    }
    
    

    
    internal func handleAddResumeCard(){
        let size = 110
        
        if textBox.hasText && timeText.hasText && titleText.hasText && button.backgroundColor == Color.grey.base && textBox.text != placeHolder && timeText.text != placeHolderTime && titleText.text != placeHolderTitle{
            button.backgroundColor = Color.lightGreen.base
            textBox.resignFirstResponder()
            timeText.resignFirstResponder()
        }
        else if button.backgroundColor == Color.lightGreen.base{
            words = textBox.text!
            timeWords = timeText.text!
            titleWords = titleText.text!
            textBox.textColor = Color.grey.lighten1
            timeText.textColor = Color.grey.lighten1
            titleText.textColor = Color.grey.lighten1
            textBox.text = placeHolder
            timeText.text = placeHolderTime
            titleText.text = placeHolderTitle
            textBox.resignFirstResponder()
            timeText.resignFirstResponder()
            titleText.resignFirstResponder()
            addResumeCard(y: 50, vc: self.scrollView, text: words, text2: timeWords, text3: titleWords)
            resumeCardBottom += size+resumeCardSpacing
        }
        else{
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
    
    
    internal func addResumeCard(y: Int, vc: UIScrollView, text: String, text2: String, text3: String){
        let card: ResumeCard = ResumeCard(vc: self, x: 25, y: 190 + 210*(resumeCards.count), width: width - 50, height: 200, text: text, text2: text2, text3: text3)
        card.cornerRadius = 10
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
        if (textBox.hasText && textBox.text != placeHolder && timeText.hasText && timeText.text != placeHolderTime && titleText.hasText && titleText.text != placeHolderTitle){
            button.backgroundColor = Color.lightGreen.base
        }
        else{
            button.backgroundColor = Color.grey.base
        }
        textBox.resignFirstResponder()
        timeText.resignFirstResponder()
    }
    
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        if textBox.text != "" && timeText.text != "" && titleText.text != "" && textBox.text != placeHolder && timeText.text != placeHolderTime && titleText.text != placeHolderTitle{
        button.backgroundColor = Color.lightGreen.base
        }
        return true
        
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == placeHolder || textField.text == placeHolderTime || titleText.text == placeHolderTitle{
            textField.text = ""
            textField.textColor = Color.black
        }

    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        button.backgroundColor = Color.grey.base
        return true
    }
    
    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField.text == "" {
            if textField == textBox {
                textField.textColor = Color.grey.lighten1
                textField.text = placeHolder
            }
            else if textField == timeText{
                textField.textColor = Color.grey.lighten1
                textField.text = placeHolderTime
            }
            else if textField == titleText{
                textField.textColor = Color.grey.lighten1
                textField.text = placeHolderTitle

            }
            button.backgroundColor = Color.grey.base
        }
    }
    
    
}
