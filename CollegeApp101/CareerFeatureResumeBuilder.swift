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
    var words: String = "Input resume item 2"
    let placeHolder = "Keep your accomplishments here for when you apply for college"
    let textBox: UITextView = UITextView()
    var textBoxSize = 50

    private lazy var menuView: MenuView = MenuView()
    
    /// Default spacing size
    let spacing: CGFloat = 16
    
    /// Diameter for FabButtons.
    let diameter: CGFloat = 56
    
    /// Height for FlatButtons.

    
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
        prepareMenuViewExample()
        refreshScrollView(1000) //use when pushing stuff off the screen
    }
    
  
    
    private func prepareMainButtons(){
        
        let button: FlatButton = FlatButton()
        button.frame = CGRect(x: width/2 + width/4 - 25, y: height - 60, width: 75, height: 25)
        button.setTitleColor(MaterialColor.white, forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Scope One", size: 10)
        button.setTitle("Add Card", forState: .Normal)
        button.backgroundColor = MaterialColor.amber.base
        button.addTarget(self, action: #selector(handleAddResumeCard), forControlEvents: .TouchUpInside)
        features.append(button)
        
        
    }
    
    internal func handleMenu() {
        if menuView.menu.opened {
            menuView.menu.close()
            (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0))
        } else {
            menuView.menu.open() { (v: UIView) in
                (v as? MaterialButton)?.pulse()
            }
            (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0.125))
        }
    }

    
    @objc(handleButton:)
    internal func handleButton(button: UIButton) {
        print("Hit Button \(button)")
    }

    
    private func prepareMenuViewExample() {
        var image: UIImage? = UIImage(named: "ic_add_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn1: FabButton = FabButton()
        btn1.depth = .None
        btn1.tintColor = MaterialColor.blue.accent3
        btn1.borderColor = MaterialColor.blue.accent3
        btn1.backgroundColor = MaterialColor.white
        btn1.borderWidth = 1
        btn1.setImage(image, forState: .Normal)
        btn1.setImage(image, forState: .Highlighted)
        btn1.addTarget(self, action: #selector(handleMenu), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn1)
        
        image = UIImage(named: "ic_create_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn2: FabButton = FabButton()
        btn2.depth = .None
        btn2.tintColor = MaterialColor.blue.accent3
        btn2.pulseColor = MaterialColor.blue.accent3
        btn2.borderColor = MaterialColor.blue.accent3
        btn2.backgroundColor = MaterialColor.white
        btn2.borderWidth = 1
        btn2.setImage(image, forState: .Normal)
        btn2.setImage(image, forState: .Highlighted)
        btn2.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn2)
        
        image = UIImage(named: "ic_photo_camera_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn3: FabButton = FabButton()
        btn3.depth = .None
        btn3.tintColor = MaterialColor.blue.accent3
        btn3.pulseColor = MaterialColor.blue.accent3
        btn3.borderColor = MaterialColor.blue.accent3
        btn3.backgroundColor = MaterialColor.white
        btn3.borderWidth = 1
        btn3.setImage(image, forState: .Normal)
        btn3.setImage(image, forState: .Highlighted)
        btn3.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn3)
        
        image = UIImage(named: "ic_note_add_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn4: FabButton = FabButton()
        btn4.depth = .None
        btn4.tintColor = MaterialColor.blue.accent3
        btn4.pulseColor = MaterialColor.blue.accent3
        btn4.borderColor = MaterialColor.blue.accent3
        btn4.backgroundColor = MaterialColor.white
        btn4.borderWidth = 1
        btn4.setImage(image, forState: .Normal)
        btn4.setImage(image, forState: .Highlighted)
        btn4.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn4)
        
        // Initialize the menu and setup the configuration options.
        menuView.menu.direction = .Up
        menuView.menu.baseSize = CGSizeMake(diameter, diameter)
        menuView.menu.views = [btn1, btn2, btn3, btn4]
        
        view.layout(menuView).width(diameter).height(diameter).bottom(16).centerHorizontally()		
    }


    private func prepareTextField(){
        textBox.frame = CGRect(x: 20, y: 50, width: width - 40, height: 80)
        textBox.delegate = self
        textBox.backgroundColor = MaterialColor.white
        textBox.font = RobotoFont.lightWithSize(16)
        textBox.textColor = MaterialColor.grey.lighten1
        textBox.text! = placeHolder
        textBox.layer.cornerRadius = 10
        features.append(textBox)
        
    }
    
    internal func handleAddResumeCard(){
        let size = 110
        words = textBox.text!
        textBox.text = ""
        textBox.resignFirstResponder()
        addResumeCard(50, vc: self.scrollView, text: words)
        resumeCardBottom += size+resumeCardSpacing

        if(resumeCardBottom > Int(self.view.frame.height)){
            refreshScrollView(resumeCardBottom)
        }
    }
    
    internal func addResumeCard(y: Int, vc: UIScrollView, text: String){
        let card: ResumeCard = ResumeCard(vc: self, x: 25, y: 180 + 110*(resumeCards.count), width: width - 50, height: 100, text: text)
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
        textBox.resignFirstResponder()
    }
    
    public func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textBox.textColor == MaterialColor.grey.lighten1{
            textBox.text! = ""
            textBox.textColor = MaterialColor.black
        }
        return true
    }
    
    public func textViewDidEndEditing(textView: UITextView) {
        
        if textBox.text == "" {
            
            textBox.text = placeHolder
            textBox.textColor = MaterialColor.grey.lighten1
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