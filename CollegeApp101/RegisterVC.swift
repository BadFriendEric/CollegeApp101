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
    private var nameField: TextField!
    private var emailField: ErrorTextField!
    private var passwordField: TextField!
    private var passwordRepeatField: TextField!
    private var resetUser: IconButton!
    private var resetPass: IconButton!
    private var helpButton: IconButton!
    private var backButton: IconButton!
    
    private var username: String!
    
    private var password: String!
    
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
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        emailField.width = view.bounds.height - 80
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
        btn2.addTarget(self, action: #selector(handleRegisterResponderButton), forControlEvents: .TouchUpInside)
        btn2.setTitle("Continue", forState: .Normal)
        btn2.setTitleColor(MaterialColor.black, forState: .Normal)
        btn2.setTitleColor(MaterialColor.black, forState: .Highlighted)
        btn2.backgroundColor = MaterialColor.blue.lighten2
        
        view.layout(btn2).bottom(200).centerHorizontally()
    }
    
    private func prepareLogo(){
        
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRectMake(80, 30, 160, 160));
        imageView.image = UIImage(named:"CA101logoPNG")
        self.view.addSubview(imageView)
        
    }
    
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    private func prepareHelpButton(){
        let helpButtonImage: UIImage? = MaterialIcon.cm.search
        helpButton = IconButton()
        helpButton.pulseColor = MaterialColor.white
        helpButton.tintColor = MaterialColor.white
        helpButton.setImage(helpButtonImage, forState: .Normal)
        helpButton.setImage(helpButtonImage, forState: .Highlighted)
        helpButton.addTarget(self, action: #selector(handleHelpButton), forControlEvents: .TouchUpInside)
        
        view.layout(helpButton).top(8).right(3)
    }
    
    private func prepareBackButton(){
        let menuButtonImage: UIImage? = MaterialIcon.cm.close
        backButton = IconButton()
        backButton.pulseColor = MaterialColor.white
        backButton.tintColor = MaterialColor.white
        backButton.setImage(menuButtonImage, forState: .Normal)
        backButton.setImage(menuButtonImage, forState: .Highlighted)
        backButton.addTarget(self, action: #selector(handleBackButton), forControlEvents: .TouchUpInside)
        
        view.layout(backButton).top(8).left(3)
    }

    internal func handleHelpButton() {
        nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        passwordRepeatField?.resignFirstResponder()

    }

    internal func handleBackButton() {

        let secondViewController:UIViewController = LoginVC()
        self.presentViewController(secondViewController, animated: true, completion: nil)
    
    
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
        nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        passwordRepeatField?.resignFirstResponder()
        
        let secondViewController:UIViewController = MySwipeVC()
        self.presentViewController(secondViewController, animated: true, completion: nil)

    }
    
    
    /// Prepares the name TextField.
    private func prepareNameField() {
        nameField = ErrorTextField(frame: CGRectMake(40, 120, view.bounds.width - 80, 32))
        nameField.placeholder = "Name"
        nameField.detail = "Error, please enter a name"
        nameField.enableClearIconButton = true
        nameField.delegate = self
        
        nameField.placeholderColor = MaterialColor.black
        nameField.placeholderActiveColor = MaterialColor.black
        nameField.dividerColor = MaterialColor.black
        
        // Setting the visibilityFlatButton color.
        nameField.visibilityIconButton?.tintColor = MaterialColor.green.base.colorWithAlphaComponent(nameField.secureTextEntry ? 0.38 : 0.54)

        
        view.layout(nameField).top(55).horizontally(left: 40, right: 40)
    }

    
    /// Prepares the email TextField.
    private func prepareEmailField() {
        emailField = ErrorTextField(frame: CGRectMake(40, 120, view.bounds.width - 80, 32))
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect Email"
        emailField.enableClearIconButton = true
        emailField.delegate = self
        
        emailField.placeholderColor = MaterialColor.black
        emailField.placeholderActiveColor = MaterialColor.black
        emailField.dividerColor = MaterialColor.black
        
        //view.addSubview(emailField)
        view.layout(emailField).top(125).horizontally(left: 40, right: 40)
    }
    
    /// Prepares the password TextField.
    private func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        passwordField.enableClearIconButton = true
        passwordField.delegate = self
        passwordField.placeholderColor = MaterialColor.black
        passwordField.placeholderActiveColor = MaterialColor.black
        passwordField.dividerColor = MaterialColor.black
        
        // Setting the visibilityFlatButton color.
        passwordField.visibilityIconButton?.tintColor = MaterialColor.green.base.colorWithAlphaComponent(passwordField.secureTextEntry ? 0.38 : 0.54)
        
        // Size the TextField to the maximum width, less 40 pixels on either side
        // with a top margin of 200 pixels.
        view.layout(passwordField).top(195).horizontally(left: 40, right: 40)
    }
    
    private func preparePasswordRepeatField() {
        passwordRepeatField = TextField()
        passwordRepeatField.placeholder = "Re-type password"
        //passwordRepeatField.detail = "Check for mistakes"
        passwordRepeatField.enableClearIconButton = true
        passwordRepeatField.delegate = self
        passwordRepeatField.placeholderColor = MaterialColor.black
        passwordRepeatField.placeholderActiveColor = MaterialColor.black
        passwordRepeatField.dividerColor = MaterialColor.black
        
        // Setting the visibilityFlatButton color.
        passwordRepeatField.visibilityIconButton?.tintColor = MaterialColor.green.base.colorWithAlphaComponent(passwordRepeatField.secureTextEntry ? 0.38 : 0.54)
        
        // Size the TextField to the maximum width, less 40 pixels on either side
        // with a top margin of 200 pixels.
        view.layout(passwordRepeatField).top(265).horizontally(left: 40, right: 40)
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
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        passwordRepeatField?.resignFirstResponder()

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
