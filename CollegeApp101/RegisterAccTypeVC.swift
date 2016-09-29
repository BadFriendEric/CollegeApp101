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
    fileprivate var helpButton: IconButton!
    fileprivate var backButton: IconButton!
    fileprivate var studentBtn: RaisedButton!
    fileprivate var coachBtn: RaisedButton!
    fileprivate var parentBtn: RaisedButton!

    fileprivate var username: String!
    
    fileprivate var password: String!
    
    let width = MainSwipeController.Constants.ScreenWidth
    let height = MainSwipeController.Constants.ScreenHeight
    
    let btnW = 300
    let btnH = 100
    
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
    fileprivate func prepareView() {
        view.backgroundColor = Color.white
        view.layer.addSublayer(getGradient1())
    }
    
    fileprivate func prepareContinueButton() {
        //Continue BUTTON
        let btn2: RaisedButton = RaisedButton(frame: CGRect(x: 140, y: 550, width: 100, height: 50))
        btn2.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        btn2.setTitle("Continue", for: UIControlState())
        btn2.setTitleColor(Color.black, for: UIControlState())
        btn2.setTitleColor(Color.black, for: .highlighted)
        btn2.backgroundColor = Color.blue.lighten2
        
        self.view.addSubview(btn2)
        
    }
    
    internal func handleContinueButton(){
        let secondViewController:UIViewController = RegisterVC()
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
    /// Prepares the resign responder button.
    fileprivate func prepareStudentButton() {
        //Continue BUTTON
        studentBtn = RaisedButton(frame: CGRect(x: 35, y: 200-btnH, width: btnW, height: btnH))
        studentBtn.addTarget(self, action: #selector(handleStudentButton), for: .touchUpInside)
        studentBtn.setTitle("Student", for: UIControlState())
        studentBtn.setTitleColor(Color.black, for: UIControlState())
        studentBtn.setTitleColor(Color.black, for: .highlighted)
        studentBtn.backgroundColor = Color.blue.lighten4
        
        self.view.addSubview(studentBtn)
    }
    
    internal func handleStudentButton(){

        studentBtn.backgroundColor = Color.white
        parentBtn.backgroundColor = Color.blue.lighten4
        coachBtn.backgroundColor = Color.blue.lighten4

    }
    
    /// Prepares the resign responder button.
    fileprivate func prepareCoachButton() {
        //Continue BUTTON
        coachBtn = RaisedButton(frame: CGRect(x: 35, y: 350-btnH, width: btnW, height: btnH))
        coachBtn.addTarget(self, action: #selector(handleCoachButton), for: .touchUpInside)
        coachBtn.setTitle("Coach", for: UIControlState())
        coachBtn.setTitleColor(Color.black, for: UIControlState())
        coachBtn.setTitleColor(Color.black, for: .highlighted)
        coachBtn.backgroundColor = Color.blue.lighten4
        
        self.view.addSubview(coachBtn)
        
    }
    
    internal func handleCoachButton(){
        coachBtn.backgroundColor = Color.white
        parentBtn.backgroundColor = Color.blue.lighten4
        studentBtn.backgroundColor = Color.blue.lighten4
    }


    /// Prepares the resign responder button.
    fileprivate func prepareParentButton() {
        //Continue BUTTON
        parentBtn = RaisedButton(frame: CGRect(x: 35, y: 500-btnH, width: btnW, height: btnH))
        parentBtn.addTarget(self, action: #selector(handleParentButton), for: .touchUpInside)
        parentBtn.setTitle("Parent", for: UIControlState())
        parentBtn.setTitleColor(Color.black, for: UIControlState())
        parentBtn.setTitleColor(Color.black, for: .highlighted)
        parentBtn.backgroundColor = Color.blue.lighten4
        
        self.view.addSubview(parentBtn)
    }
    
    internal func handleParentButton(){
        parentBtn.backgroundColor = Color.white
        studentBtn.backgroundColor = Color.blue.lighten4
        coachBtn.backgroundColor = Color.blue.lighten4
    }
    

    
    
    fileprivate func prepareLogo(){
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 145, y: 25, width: 30, height: 30));
        imageView.image = UIImage(named:"CA101logoPNG")
        self.view.addSubview(imageView)
    
        
    }
    
    fileprivate func prepareHelpButton(){
        let helpButtonImage: UIImage? = Icon.cm.search
        helpButton = IconButton()
        helpButton.pulseColor = Color.white
        helpButton.tintColor = Color.white
        helpButton.setImage(helpButtonImage, for: UIControlState())
        helpButton.setImage(helpButtonImage, for: .highlighted)
        helpButton.addTarget(self, action: #selector(handleHelpButton), for: .touchUpInside)
        
        view.layout(helpButton).top(20).right(3)
    }
    
    fileprivate func prepareBackButton(){
        let menuButtonImage: UIImage? = Icon.cm.close
        backButton = IconButton()
        backButton.pulseColor = Color.white
        backButton.tintColor = Color.white
        backButton.setImage(menuButtonImage, for: UIControlState())
        backButton.setImage(menuButtonImage, for: .highlighted)
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        view.layout(backButton).top(20).left(3)
    }
    
    internal func handleHelpButton() {
        
    }
    
    internal func handleBackButton() {
        
        let secondViewController:UIViewController = LoginVC()
        self.present(secondViewController, animated: true, completion: nil)
        
        
    }
    
    fileprivate func getGradient1() -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let color1 = Color.blue.lighten2.cgColor
        let color2 = Color.deepPurple.lighten3.cgColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    /// Executed when the 'return' key is pressed when using the emailField.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.revealError = true
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.revealError = false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }
}
