//
//  ResumeCard.swift
//
//
//  Created by Eric Ota on 8/13/16.
//
// some of the variable names in this are really incorect lol i got confused
//

import Foundation
import UIKit
import Material

class ResumeCard: Card, UITextFieldDelegate{
    
    var view: CareerFeatureResumeBuilder = CareerFeatureResumeBuilder()
    
    var trash: IconButton = IconButton()
    var editBtn: IconButton = IconButton()
    var trashClicked = false
    let trashImg: UIImage? = Icon.cm.close
    let editImg: UIImage? = Icon.cm.pen
    let editColor: UIColor = Color.black
    var mysubviews = [UIView]()
    var text: String = "yes"
    var textTime: String = "pls"
    var textTitle: String = "no"
    var icon: UIImage = UIImage()
    let iconSize: Int = 30
    let buttonArea = 55
    var editOn: Bool = false
    
    var boxTime: UITextField = UITextField()
    var box: UITextField = UITextField()
    var boxTitle: UITextField = UITextField()

    
    //BUG TO FIX: WHEN U PRESS
    
    internal init(vc: CareerFeatureResumeBuilder, x: Int, y: Int, width: Int, height: Int, text: String, text2: String, text3: String){
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.view = vc
        setTrashButton()
        setTextBox(text: text, text2: text2, text3: text3)
        setEdit()
        setIcon()
        setTitleIcon()
        setTimeIcon()
        reload()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reload() {
        for v in subviews {
            v.removeFromSuperview()
        }
        for v in mysubviews {
            self.addSubview(v)
        }
    }
    
    
    
    internal func setTrashButton(){
        trash = IconButton(frame: CGRect(x: Int(self.frame.width)-45, y: 0, width: 50, height: 35))
        trash.pulseColor = Color.red.base
        trash.tintColor = Color.black
        trash.setImage(trashImg, for: .normal)
        trash.setImage(trashImg, for: .highlighted)
        trash.addTarget(self, action: #selector(handleTrashButton), for: .touchDown)  //cosider changing to touch down
        
        mysubviews.append(trash)
    }
    
    internal func resetTrashButton(){
        //let trashImg: UIImage? = MaterialIcon.cm.close
        trash.tintColor = Color.black
        //trash.setImage(trashImg, forState: .Normal)
        //trash.setImage(trashImg, forState: .Highlighted)
        UIView.animate(withDuration: 0.2, animations: {
            self.trash.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI/2))
            }, completion: { finished in
                self.trash.transform = CGAffineTransform.identity
        })
        trashClicked = false
    }
    
    
    internal func handleTrashButton(){
        if(trashClicked){
            view.deleteResumeCard(card: self)
        }else{
            //let trashImg: UIImage? = MaterialIcon.check
            UIView.animate(withDuration: 0.2, animations: {
                self.trash.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2))
                }, completion: { finished in
                    self.trash.transform = CGAffineTransform.identity
            })
            trash.tintColor = Color.red.base
            trashClicked = true
        }
        
    }
    
    func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches as! Set<UITouch>, with: event)
        if(trashClicked){
            resetTrashButton()
        }
        
    }
    
    internal func setTextBox(text: String, text2: String, text3: String){
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 15, height: box.height))
        box.leftView = paddingView
        box.leftViewMode = UITextFieldViewMode.always
        boxTime.leftView = paddingView
        boxTime.leftViewMode = UITextFieldViewMode.always
        //boxTitle.leftView = paddingView
        //boxTitle.leftViewMode = UITextFieldViewMode.always

        box = UITextField(frame: CGRect(x: iconSize + 15, y: 10, width: Int(self.frame.width) - iconSize - buttonArea, height: 30))
        box.backgroundColor = Color.white
        box.textColor = Color.black
        box.font = RobotoFont.light(with: 16)
        box.text = text3
        box.adjustsFontSizeToFitWidth = true
        box.minimumFontSize = 10
        box.isUserInteractionEnabled = false
        box.textAlignment = .left
        box.borderStyle = .none
        box.clearButtonMode = .whileEditing
        box.returnKeyType = .done
        mysubviews.append(box)
        
        boxTime = UITextField(frame: CGRect(x: iconSize + 15, y: iconSize + 20, width: Int(self.frame.width) - iconSize - buttonArea, height: 30))
        boxTime.backgroundColor = Color.white
        boxTime.textColor = Color.black
        boxTime.font = RobotoFont.light(with: 16)
        boxTime.text = text2
        boxTime.textAlignment = .left
        boxTime.borderStyle = .none
        boxTime.adjustsFontSizeToFitWidth = true
        boxTime.minimumFontSize = 10
        boxTime.isUserInteractionEnabled = false
        boxTime.clearButtonMode = .whileEditing
        boxTime.returnKeyType = .done
        mysubviews.append(boxTime)
        
        
        boxTitle = UITextField(frame: CGRect(x: iconSize + 15, y: 2*iconSize + 30, width: Int(self.frame.width) - iconSize - buttonArea, height: 30))
        boxTitle.backgroundColor = Color.white
        boxTitle.textColor = Color.black
        boxTitle.font = RobotoFont.light(with: 16)
        boxTitle.text = text
        boxTitle.textAlignment = .left
        //boxTitle.allowsEditingTextAttributes = true
        boxTitle.borderStyle = .none
        boxTitle.adjustsFontSizeToFitWidth = true
        boxTitle.minimumFontSize = 10
        boxTitle.isUserInteractionEnabled = false
        boxTitle.clearButtonMode = .whileEditing
        boxTitle.returnKeyType = .done
        mysubviews.append(boxTitle)
    }
    

    
    internal func setTitleIcon(){
        self.icon = Icon.star!
        let iconView = UIImageView(image: self.icon)
        iconView.tintColor = editColor
        iconView.frame = CGRect(x: 5, y: 10, width: iconSize, height: iconSize)
        mysubviews.append(iconView)
        
    }
    
    internal func setTimeIcon(){
        self.icon = Icon.bell!
        let iconView = UIImageView(image: self.icon)
        iconView.tintColor = editColor
        iconView.frame = CGRect(x: 5, y: iconSize + 20, width: iconSize, height: iconSize)
        mysubviews.append(iconView)
        
    }
    
    internal func setIcon(){
        self.icon = Icon.menu!
        let iconView = UIImageView(image: self.icon)
        iconView.tintColor = editColor
        iconView.frame = CGRect(x: 5, y: 2*iconSize + 30, width: iconSize, height: iconSize)
        mysubviews.append(iconView)
        
    }
    
    internal func setEdit(){
        editBtn = IconButton(frame: CGRect(x: Int(width) - 45, y: Int(height) - 10 - iconSize, width: 50, height: 35))
        editBtn.pulseColor = Color.amber.darken4
        editBtn.tintColor = editColor
        editBtn.setImage(editImg, for: .normal)
        editBtn.setImage(editImg, for: .highlighted)
        editBtn.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        
        mysubviews.append(editBtn)
        
    }
    
    internal func handleEditButton(){
        if !editOn {
            editOn = true
            box.isUserInteractionEnabled = true
            boxTime.isUserInteractionEnabled = true
            boxTitle.isUserInteractionEnabled = true
            box.backgroundColor = Color.grey.lighten2
            boxTime.backgroundColor = Color.grey.lighten2
            boxTitle.backgroundColor = Color.grey.lighten2
            editBtn.tintColor = Color.red.darken3
        }
        else{
            editOn = false
            box.isUserInteractionEnabled = false
            boxTime.isUserInteractionEnabled = false
            boxTitle.isUserInteractionEnabled = false
            box.backgroundColor = Color.white
            boxTime.backgroundColor = Color.white
            boxTitle.backgroundColor = Color.white
            editBtn.tintColor = editColor
        }
        
        
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
