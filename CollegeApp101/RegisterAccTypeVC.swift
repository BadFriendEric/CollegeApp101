//
//  RegisterAccTypeVC.swift
//  CollegeApp101
//
//  Created by Eric Ota on 8/2/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Material

class RegisterAccTypeVC: UIViewController, TextFieldDelegate {
    private var helpButton: IconButton!
    private var backButton: IconButton!
    private var studentBtn: RaisedButton!
    private var coachBtn: RaisedButton!
    private var parentBtn: RaisedButton!

    private var username: String!
    
    private var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareHelpButton()
        prepareBackButton()
        prepareLogo()
        prepareContinueButton()
        prepareStudentButton()
        prepareCoachButton()
        prepareParentButton()
    }
    
    
    /// General preparation statements.
    private func prepareView() {
        view.backgroundColor = MaterialColor.white
        view.layer.addSublayer(getGradient1())
    }
    
    /// Prepares the resign responder button.
    private func prepareContinueButton() {
        //Continue BUTTON
        let btn2: RaisedButton = RaisedButton()
        btn2.addTarget(self, action: #selector(handleContinueButton), forControlEvents: .TouchUpInside)
        btn2.setTitle("Continue", forState: .Normal)
        btn2.setTitleColor(MaterialColor.black, forState: .Normal)
        btn2.setTitleColor(MaterialColor.black, forState: .Highlighted)
        btn2.backgroundColor = MaterialColor.blue.lighten2
        
        view.layout(btn2).bottom(40).centerHorizontally()
    }
    
    internal func handleContinueButton(){
        let secondViewController:UIViewController = RegisterVC()
        self.presentViewController(secondViewController, animated: true, completion: nil)
        
    }
    
    /// Prepares the resign responder button.
    private func prepareStudentButton() {
        //Continue BUTTON
        studentBtn = RaisedButton()
        studentBtn.addTarget(self, action: #selector(handleStudentButton), forControlEvents: .TouchUpInside)
        studentBtn.setTitle("Student", forState: .Normal)
        studentBtn.setTitleColor(MaterialColor.black, forState: .Normal)
        studentBtn.setTitleColor(MaterialColor.black, forState: .Highlighted)
        studentBtn.backgroundColor = MaterialColor.blue.lighten4
        
        view.layout(studentBtn).bottom(360).horizontally(left: 20, right: 20).height(100)
    }
    
    internal func handleStudentButton(){

        studentBtn.backgroundColor = MaterialColor.white
        parentBtn.backgroundColor = MaterialColor.blue.lighten4
        coachBtn.backgroundColor = MaterialColor.blue.lighten4

    }
    
    /// Prepares the resign responder button.
    private func prepareCoachButton() {
        //Continue BUTTON
        coachBtn = RaisedButton()
        coachBtn.addTarget(self, action: #selector(handleCoachButton), forControlEvents: .TouchUpInside)
        coachBtn.setTitle("Coach", forState: .Normal)
        coachBtn.setTitleColor(MaterialColor.black, forState: .Normal)
        coachBtn.setTitleColor(MaterialColor.black, forState: .Highlighted)
        coachBtn.backgroundColor = MaterialColor.blue.lighten4
        
        view.layout(coachBtn).bottom(240).horizontally(left: 20, right: 20).height(100)
    }
    
    internal func handleCoachButton(){
        coachBtn.backgroundColor = MaterialColor.white
        parentBtn.backgroundColor = MaterialColor.blue.lighten4
        studentBtn.backgroundColor = MaterialColor.blue.lighten4
    }


    /// Prepares the resign responder button.
    private func prepareParentButton() {
        //Continue BUTTON
        parentBtn = RaisedButton()
        parentBtn.addTarget(self, action: #selector(handleParentButton), forControlEvents: .TouchUpInside)
        parentBtn.setTitle("Parent", forState: .Normal)
        parentBtn.setTitleColor(MaterialColor.black, forState: .Normal)
        parentBtn.setTitleColor(MaterialColor.black, forState: .Highlighted)
        parentBtn.backgroundColor = MaterialColor.blue.lighten4
        
        view.layout(parentBtn).bottom(120).horizontally(left: 20, right: 20).height(100)
    }
    
    internal func handleParentButton(){
        parentBtn.backgroundColor = MaterialColor.white
        studentBtn.backgroundColor = MaterialColor.blue.lighten4
        coachBtn.backgroundColor = MaterialColor.blue.lighten4
    }
    

    
    
    private func prepareLogo(){
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRectMake(145, 25, 30, 30));
        imageView.image = UIImage(named:"CA101logoPNG")
        self.view.addSubview(imageView)
    
        
    }
    
    private func prepareHelpButton(){
        let helpButtonImage: UIImage? = MaterialIcon.cm.search
        helpButton = IconButton()
        helpButton.pulseColor = MaterialColor.white
        helpButton.tintColor = MaterialColor.white
        helpButton.setImage(helpButtonImage, forState: .Normal)
        helpButton.setImage(helpButtonImage, forState: .Highlighted)
        helpButton.addTarget(self, action: #selector(handleHelpButton), forControlEvents: .TouchUpInside)
        
        view.layout(helpButton).top(20).right(3)
    }
    
    private func prepareBackButton(){
        let menuButtonImage: UIImage? = MaterialIcon.cm.close
        backButton = IconButton()
        backButton.pulseColor = MaterialColor.white
        backButton.tintColor = MaterialColor.white
        backButton.setImage(menuButtonImage, forState: .Normal)
        backButton.setImage(menuButtonImage, forState: .Highlighted)
        backButton.addTarget(self, action: #selector(handleBackButton), forControlEvents: .TouchUpInside)
        
        view.layout(backButton).top(20).left(3)
    }
    
    internal func handleHelpButton() {
        
    }
    
    internal func handleBackButton() {
        
        let secondViewController:UIViewController = LoginVC()
        self.presentViewController(secondViewController, animated: true, completion: nil)
        
        
    }
    
    private func getGradient1() -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let color1 = MaterialColor.blue.lighten2.CGColor
        let color2 = MaterialColor.deepPurple.lighten3.CGColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    /// Executed when the 'return' key is pressed when using the emailField.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.revealError = true
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