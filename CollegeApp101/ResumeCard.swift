//
//  ResumeCard.swift
//  
//
//  Created by Eric Ota on 8/13/16.
//
//

import Foundation
import UIKit
import Material

class ResumeCard: CardView{
    
    var view: CareerFeatureResumeBuilder = CareerFeatureResumeBuilder()

    var trash: IconButton = IconButton()
    var trashClicked = false
    let trashImg: UIImage? = MaterialIcon.cm.close
    
    var mysubviews = [UIView]()
    var text: String = "yes"
    var icon: UIImage = UIImage()
    let iconSize = 50

    
    
    internal init(vc: CareerFeatureResumeBuilder, x: Int, y: Int, width: Int, height: Int, text: String){
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.view = vc
        
        setTrashButton()
        setTextBox(text)
        setIcon()
        reloadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func reloadView() {
        for v in subviews {
            v.removeFromSuperview()
        }
        for v in mysubviews {
            self.addSubview(v)
        }
    }

    
    
    internal func setTrashButton(){
        trash = IconButton(frame: CGRect(x: Int(self.frame.width)-45, y: Int(self.frame.height - 10), width: Int(self.frame.width) - iconSize - 50, height: Int(self.frame.height)-35))
        trash.pulseColor = MaterialColor.red.base
        trash.tintColor = MaterialColor.black
        trash.setImage(trashImg, forState: .Normal)
        trash.setImage(trashImg, forState: .Highlighted)
        trash.addTarget(self, action: #selector(handleTrashButton), forControlEvents: .TouchUpInside)  //cosider changing to touch down
        
        mysubviews.append(trash)
    }
    
    internal func resetTrashButton(){
        //let trashImg: UIImage? = MaterialIcon.cm.close
        trash.tintColor = MaterialColor.black
        //trash.setImage(trashImg, forState: .Normal)
        //trash.setImage(trashImg, forState: .Highlighted)
        UIView.animateWithDuration(0.2, animations: {
            self.trash.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI/2))
            }, completion: { finished in
                self.trash.transform = CGAffineTransformIdentity
        })
        trashClicked = false
    }
    
    
    internal func handleTrashButton(){
        if(trashClicked){
            view.deleteResumeCard(self)
        }else{
            //let trashImg: UIImage? = MaterialIcon.check
            UIView.animateWithDuration(0.2, animations: {
                self.trash.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
                }, completion: { finished in
                    self.trash.transform = CGAffineTransformIdentity
            })
            trash.tintColor = MaterialColor.red.base
            trashClicked = true
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if(trashClicked){
            resetTrashButton()
        }
        
    }
    
    internal func setTextBox(text: String){
        let box = UITextField(frame: CGRect(x: iconSize + 20, y: 0, width: Int(self.frame.width) - iconSize - 50, height: Int(self.frame.height)-35))
        //box.backgroundColor = MaterialColor.grey.lighten3
        box.textColor = MaterialColor.black
        box.font = RobotoFont.lightWithSize(16)
        box.text = text
        box.adjustsFontSizeToFitWidth = true
        mysubviews.append(box)
        
        
        
    }

    internal func setIcon(){
        self.icon = MaterialIcon.star!
        self.icon.tintWithColor(MainPanels.Constants.Color3)
        let iconView = UIImageView(image: self.icon)
        iconView.frame = CGRect(x: 5, y: 5, width: iconSize, height: iconSize)
        mysubviews.append(iconView)
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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