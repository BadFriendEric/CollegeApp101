//
//  LoginVC.swift
//  CollegeApp101
//
//  Created by Eric Ota on 8/1/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Material
import AWSCore
import AWSCognito

class LoginVC: UIViewController, TextFieldDelegate {
    fileprivate var nameField: TextField!
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    fileprivate var resetUser: IconButton!
    fileprivate var resetPass: IconButton!
    
    fileprivate var imageSize: CGFloat = 300
    
    let width = MainSwipeController.Constants.ScreenWidth
    let height = MainSwipeController.Constants.ScreenHeight
    
    
    
    let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USWest2, identityPoolId: "us-west-2:73ace396-1072-46b3-ad9a-5e04db7da2a6")
    
    var syncClient : AWSCognito? = nil
    
    //let syncClient = AWSCognito.default()
    

    fileprivate var username: String!
    
    fileprivate var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareAWS()
        prepareAWSCognito()
        //prepareNameField()
        prepareEmailField()
        preparePasswordField()
        prepareResignResponderButton()
        prepareLogo()
    }
    

    fileprivate func prepareAWS(){
        
        
        let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
    }
    
    fileprivate func prepareAWSCognito(){
        
        syncClient = AWSCognito.default()
        
        // Create a record in a dataset and synchronize with the server
        
//        credentialsProvider.getIdentityId().continueWith { (task: AWSTask!) -> AnyObject! in
//            
//            if (task.error != nil) {
//                print("Error: " + (task.error?.localizedDescription)!)
//                
//            } else {
//                // the task result will contain the identity id
//                let cognitoId = task.result
//                print(cognitoId)
//            }
//            return nil
//        }
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
    fileprivate func prepareResignResponderButton() {
        
        //LOGIN BUTTON
        let btn: RaisedButton = RaisedButton()
        btn.addTarget(self, action: #selector(handleLoginResponderButton), for: .touchUpInside)
        btn.setTitle("Login", for: UIControlState())
        btn.setTitleColor(Color.black, for: UIControlState())
        btn.setTitleColor(Color.black, for: .highlighted)
        btn.backgroundColor = Color.white
        btn.cornerRadius = 10
        
        _ = view.layout(btn).width(80).height(40).left(width/2-105).top(345)
        
        
        //REGISTER BUTTON
        let btn2: RaisedButton = RaisedButton()
        btn2.addTarget(self, action: #selector(handleRegisterResponderButton), for: .touchUpInside)
        btn2.setTitle("Register", for: UIControlState())
        btn2.setTitleColor(Color.black, for: UIControlState())
        btn2.setTitleColor(Color.black, for: .highlighted)
        btn2.backgroundColor = Color.white
        btn2.cornerRadius = 10
        
        
        _ = view.layout(btn2).width(100).height(40).left(width/2+5).top(345)
        
    }
    
    fileprivate func prepareLogo(){
        var imageView : UIImageView
        imageView = UIImageView(frame:CGRect(x: width/2 - imageSize/2, y: 10, width: imageSize, height: imageSize))
        imageView.contentMode = .scaleAspectFit
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
        
        var dataset = syncClient?.openOrCreateDataset("Client1")
        dataset?.setString(username, forKey:"username")
        dataset?.setString(password, forKey:"password")
        dataset?.synchronize().continueWith {(task: AWSTask!) -> AnyObject! in
            // Your handler code here
            return nil
            
        }

        
        let secondViewController:UIViewController = MainPanels()
        self.present(secondViewController, animated: true, completion: nil)
        
        print(username)
        print(password)
    }

    
    internal func handleRegisterResponderButton() {
        //nameField?.resignFirstResponder()
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        
        let secondViewController:UIViewController = RegisterAccTypeVC()
        self.present(secondViewController, animated: true, completion: nil)

        }

    
    /// Prepares the name TextField.
    fileprivate func prepareNameField() {
        nameField = TextField()
        nameField.text = "Salty Sam"
        nameField.placeholder = "College App 101"
        nameField.detail = "Name"
        nameField.textAlignment = .left
        nameField.clearButtonMode = .whileEditing
        
        // Size the TextField to the maximum width, less 40 pixels on either side
        // with a top margin of 40 pixels.
        _ = view.layout(nameField).top(40).horizontally(left: 40, right: 40)
    }
    
    /// Prepares the email TextField.
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField(frame: CGRect(x: 40, y: 120, width: width - 80, height: 32))
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect Email"
        //emailField.enableClearIconButton = true
        emailField.delegate = self
        
        emailField.placeholderNormalColor = Color.black
        emailField.placeholderActiveColor = Color.black
        emailField.dividerColor = Color.black
        
        //view.addSubview(emailField)
        _ = view.layout(emailField).top(240).horizontally(left: 40, right: 40)
    }
    
    /// Prepares the password TextField.
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        //passwordField.detail = "At least 8 characters"
        //passwordField.enableClearIconButton = true
        passwordField.delegate = self
        passwordField.placeholderNormalColor = Color.black
        passwordField.placeholderActiveColor = Color.black
        passwordField.dividerColor = Color.black
        
        // Setting the visibilityFlatButton color.
        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        // Size the TextField to the maximum width, less 40 pixels on either side
        // with a top margin of 200 pixels.
        _ = view.layout(passwordField).top(290).horizontally(left: 40, right: 40)
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
}
