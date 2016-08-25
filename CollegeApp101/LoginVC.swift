//
//  LoginVC.swift
//  CollegeApp101
//
//  Created by Eric Ota on 8/1/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Material

class LoginVC: UIViewController, TextFieldDelegate {
    private var nameField: TextField!
    private var emailField: ErrorTextField!
    private var passwordField: TextField!
    private var resetUser: IconButton!
    private var resetPass: IconButton!
    
    private var imageSize: CGFloat = 300
    
    let width = EZSwipeController.Constants.ScreenWidth
    let height = EZSwipeController.Constants.ScreenHeight

    private var username: String!
    
    private var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        //prepareNameField()
        prepareEmailField()
        preparePasswordField()
        prepareResignResponderButton()
        prepareLogo()
    }
    


    
    
    /// Programmatic update for the textField as it rotates.
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        emailField.width = view.bounds.height - 80
    }
    
    /// General preparation statements.
    private func prepareView() {
        view.backgroundColor = MaterialColor.white
        view.layer.addSublayer(getGradient1())
    }
    
    /// Prepares the resign responder button.
    private func prepareResignResponderButton() {
        
        //LOGIN BUTTON
        let btn: RaisedButton = RaisedButton()
        btn.addTarget(self, action: #selector(handleLoginResponderButton), forControlEvents: .TouchUpInside)
        btn.setTitle("Login", forState: .Normal)
        btn.setTitleColor(MaterialColor.black, forState: .Normal)
        btn.setTitleColor(MaterialColor.black, forState: .Highlighted)
        btn.backgroundColor = MaterialColor.white
        
        view.layout(btn).width(80).height(40).top(345).centerHorizontally(-70)
        
        
        //REGISTER BUTTON
        let btn2: RaisedButton = RaisedButton()
        btn2.addTarget(self, action: #selector(handleRegisterResponderButton), forControlEvents: .TouchUpInside)
        btn2.setTitle("Register", forState: .Normal)
        btn2.setTitleColor(MaterialColor.black, forState: .Normal)
        btn2.setTitleColor(MaterialColor.black, forState: .Highlighted)
        btn2.backgroundColor = MaterialColor.white
        
        view.layout(btn2).width(100).height(40).top(345).centerHorizontally(70)
        
        
    }
    
    private func prepareLogo(){
        var imageView : UIImageView
        imageView = UIImageView(frame:CGRectMake(width/2 - imageSize/2, 10, imageSize, imageSize))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named:"logo")
        
        self.view.addSubview(imageView)

    }


    
    /// Handle the resign responder button.
    internal func handleLoginResponderButton() {
        //nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        
        username = emailField.text
        password = passwordField.text
        
        let secondViewController:UIViewController = MySwipeVC()
        self.presentViewController(secondViewController, animated: true, completion: nil)
        
        print(username)
        print(password)
    }

    
    internal func handleRegisterResponderButton() {
        //nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        
        let secondViewController:UIViewController = RegisterAccTypeVC()
        self.presentViewController(secondViewController, animated: true, completion: nil)

        }

    
    /// Prepares the name TextField.
    private func prepareNameField() {
        nameField = TextField()
        nameField.text = "Salty Sam"
        nameField.placeholder = "College App 101"
        nameField.detail = "Name"
        nameField.textAlignment = .Left
        nameField.clearButtonMode = .WhileEditing
        
        // Size the TextField to the maximum width, less 40 pixels on either side
        // with a top margin of 40 pixels.
        view.layout(nameField).top(40).horizontally(left: 40, right: 40)
    }
    
    /// Prepares the email TextField.
    private func prepareEmailField() {
        emailField = ErrorTextField(frame: CGRectMake(40, 120, width - 80, 32))
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect Email"
        emailField.enableClearIconButton = true
        emailField.delegate = self
        
        emailField.placeholderColor = MaterialColor.black
        emailField.placeholderActiveColor = MaterialColor.black
        emailField.dividerColor = MaterialColor.black
        
        //view.addSubview(emailField)
        view.layout(emailField).top(240).horizontally(left: 40, right: 40)
    }
    
    /// Prepares the password TextField.
    private func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        //passwordField.detail = "At least 8 characters"
        passwordField.enableClearIconButton = true
        passwordField.delegate = self
        passwordField.placeholderColor = MaterialColor.black
        passwordField.placeholderActiveColor = MaterialColor.black
        passwordField.dividerColor = MaterialColor.black
        
        // Setting the visibilityFlatButton color.
        passwordField.visibilityIconButton?.tintColor = MaterialColor.green.base.colorWithAlphaComponent(passwordField.secureTextEntry ? 0.38 : 0.54)
        
        // Size the TextField to the maximum width, less 40 pixels on either side
        // with a top margin of 200 pixels.
        view.layout(passwordField).top(290).horizontally(left: 40, right: 40)
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
