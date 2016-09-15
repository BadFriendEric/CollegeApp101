//
//  RegisterVC.swift
//  CollegeApp101
//
//  Created by Eric Ota on 8/2/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Material

class RegisterVC: UIViewController, TextFieldDelegate {
    fileprivate var nameField: TextField!
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    fileprivate var passwordRepeatField: TextField!
    fileprivate var resetUser: IconButton!
    fileprivate var resetPass: IconButton!
    fileprivate var helpButton: IconButton!
    fileprivate var backButton: IconButton!
    
    fileprivate var username: String!
    
    fileprivate var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareHelpButton()
        prepareBackButton()
        prepareContinueButton()
        prepareNameField()
        prepareEmailField()
        preparePasswordField()
        preparePasswordRepeatField()
    }
    
    
    
    
    
    /// Programmatic update for the textField as it rotates.
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        emailField.width = view.bounds.height - 80
    }
    
    /// General preparation statements.
    fileprivate func prepareView() {
        view.backgroundColor = Color.white
        view.layer.addSublayer(getGradient1())
    }
    
    /// Prepares the resign responder button.
    fileprivate func prepareContinueButton() {
        //Continue BUTTON
        let btn2: RaisedButton = RaisedButton()
        btn2.addTarget(self, action: #selector(handleRegisterResponderButton), for: .touchUpInside)
        btn2.setTitle("Continue", for: UIControlState())
        btn2.setTitleColor(Color.black, for: UIControlState())
        btn2.setTitleColor(Color.black, for: .highlighted)
        btn2.backgroundColor = Color.blue.lighten2
        
        _ = view.layout(btn2).bottom(200).centerHorizontally()
    }
    
    fileprivate func prepareLogo(){
        
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 80, y: 30, width: 160, height: 160));
        imageView.image = UIImage(named:"CA101logoPNG")
        self.view.addSubview(imageView)
        
    }
    
    
    func ResizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    fileprivate func prepareHelpButton(){
        let helpButtonImage: UIImage? = Icon.cm.search
        helpButton = IconButton()
        helpButton.pulseColor = Color.white
        helpButton.tintColor = Color.white
        helpButton.setImage(helpButtonImage, for: UIControlState())
        helpButton.setImage(helpButtonImage, for: .highlighted)
        helpButton.addTarget(self, action: #selector(handleHelpButton), for: .touchUpInside)
        
        _ = view.layout(helpButton).top(8).right(3)
    }
    
    fileprivate func prepareBackButton(){
        let menuButtonImage: UIImage? = Icon.cm.close
        backButton = IconButton()
        backButton.pulseColor = Color.white
        backButton.tintColor = Color.white
        backButton.setImage(menuButtonImage, for: UIControlState())
        backButton.setImage(menuButtonImage, for: .highlighted)
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        _ = view.layout(backButton).top(8).left(3)
    }

    internal func handleHelpButton() {
        nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        passwordRepeatField?.resignFirstResponder()

    }

    internal func handleBackButton() {

        let secondViewController:UIViewController = LoginVC()
        self.present(secondViewController, animated: true, completion: nil)
    
    
    }

    
    /// Handle the resign responder button.
    internal func handleLoginResponderButton() {
        //nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        
        username = emailField.text
        password = passwordField.text
        
        let secondViewController:UIViewController = MainPanels()
        self.present(secondViewController, animated: true, completion: nil)
        
        print(username)
        print(password)
    }
    
    
    internal func handleRegisterResponderButton() {
        nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        passwordRepeatField?.resignFirstResponder()
        
        let secondViewController:UIViewController = MainPanels()
        self.present(secondViewController, animated: true, completion: nil)

    }
    
    
    /// Prepares the name TextField.
    fileprivate func prepareNameField() {
        nameField = ErrorTextField(frame: CGRect(x: 40, y: 120, width: view.bounds.width - 80, height: 32))
        nameField.placeholder = "Name"
        nameField.detail = "Error, please enter a name"
        //nameField.enableClearIconButton = true
        nameField.delegate = self
        
        nameField.placeholderColor = Color.black
        nameField.placeholderActiveColor = Color.black
        nameField.dividerColor = Color.black
        
        // Setting the visibilityFlatButton color.
        nameField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(nameField.isSecureTextEntry ? 0.38 : 0.54)

        
        _ = view.layout(nameField).top(55).horizontally(left: 40, right: 40)
    }

    
    /// Prepares the email TextField.
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField(frame: CGRect(x: 40, y: 120, width: view.bounds.width - 80, height: 32))
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect Email"
        //emailField.enableClearIconButton = true
        emailField.delegate = self
        
        emailField.placeholderColor = Color.black
        emailField.placeholderActiveColor = Color.black
        emailField.dividerColor = Color.black
        
        //view.addSubview(emailField)
        _ = view.layout(emailField).top(125).horizontally(left: 40, right: 40)
    }
    
    /// Prepares the password TextField.
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        //passwordField.enableClearIconButton = true
        passwordField.delegate = self
        passwordField.placeholderColor = Color.black
        passwordField.placeholderActiveColor = Color.black
        passwordField.dividerColor = Color.black
        
        // Setting the visibilityFlatButton color.
        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        // Size the TextField to the maximum width, less 40 pixels on either side
        // with a top margin of 200 pixels.
        _ = view.layout(passwordField).top(195).horizontally(left: 40, right: 40)
    }
    
    fileprivate func preparePasswordRepeatField() {
        passwordRepeatField = TextField()
        passwordRepeatField.placeholder = "Re-type password"
        //passwordRepeatField.detail = "Check for mistakes"
        //passwordRepeatField.enableClearIconButton = true
        passwordRepeatField.delegate = self
        passwordRepeatField.placeholderColor = Color.black
        passwordRepeatField.placeholderActiveColor = Color.black
        passwordRepeatField.dividerColor = Color.black
        
        // Setting the visibilityFlatButton color.
        passwordRepeatField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordRepeatField.isSecureTextEntry ? 0.38 : 0.54)
        
        // Size the TextField to the maximum width, less 40 pixels on either side
        // with a top margin of 200 pixels.
        _ = view.layout(passwordRepeatField).top(265).horizontally(left: 40, right: 40)
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        passwordRepeatField?.resignFirstResponder()

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
