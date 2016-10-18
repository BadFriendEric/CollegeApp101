//
//  Profile.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 10/4/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import Foundation
import UIKit

class Profile {
    
    enum Grade {
        case Freshman
        case Sophomore
        case Junior
        case Senior
        case Other
        
        
        
    }
    
    let userDefaults = UserDefaults.standard
    
    private var username: String = "test"
    private var password: String = "123"
    private var firstName = "Sam"
    private var lastName = "Hollenbach"
    private var profilePicture : UIImage = UIImage(named: "ProfileDefault1")!
    private var grade : Grade = Grade.Other
    
    
    internal init(user : String, pass: String){
        userDefaults.set(user, forKey: username)
        userDefaults.set(pass, forKey: password)
    }
    
    public func setUsername(user: String){
        userDefaults.set(user, forKey: username)
    }
    
    public func setPassword(pass: String){
        userDefaults.set(pass, forKey: password)
    }
    
    public func setTrueName(first: String, last: String){
        /*
        self.firstName = first
        self.lastName = last
        */
        userDefaults.set(first, forKey: firstName)
        userDefaults.set(last, forKey: lastName)
    }
    
    public func setFirstName(firstName: String){
        userDefaults.set(firstName, forKey: firstName)
    }
    
    public func setLastName(lastName: String){
        userDefaults.set(lastName, forKey: lastName)
    }
    
    public func setProfilePic(pic: UIImage){
        self.profilePicture = pic
    }
    
    public func setGrade(grade : Grade){
        self.grade = grade
    }
    
    
    public func getUsername() -> String{
        return userDefaults.object(forKey: username) as! String
    }
    
    
    public func getPassword() -> String{
        return userDefaults.object(forKey: password) as! String
    }
    
    public func getFirstName() -> String{
        return userDefaults.string(forKey: firstName)!
    }
    
    public func getLastName() -> String{
        return userDefaults.string(forKey: lastName)!
    }
    
    public func getFullName() -> String{
        return firstName + " " + lastName
    }
    
    public func getProfilePicture() -> UIImage{
        return profilePicture
    }
    
    public func getGrade() -> Grade{
        return grade
    }
    
    
    
    
    
    
}
