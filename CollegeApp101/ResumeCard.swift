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

class ResumeCard: Card{
    
    var view: CareerFeatureResumeBuilder = CareerFeatureResumeBuilder()

    var trash: IconButton = IconButton()
    var trashClicked = false
    let trashImg: UIImage? = Icon.cm.close
    
    var mysubviews = [UIView]()
    var text: String = "yes"
    var textTime: String = "pls"
    var icon: UIImage = UIImage()
    let iconSize = 30

    
    
    internal init(vc: CareerFeatureResumeBuilder, x: Int, y: Int, width: Int, height: Int, text: String, text2: String){
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.view = vc
        divider = false
        setTrashButton()
        setTextBox(text, text2: text2)
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
        trash.pulseColor = Color.red.base
        trash.tintColor = Color.black
        trash.setImage(trashImg, for: UIControlState())
        trash.setImage(trashImg, for: .highlighted)
        trash.addTarget(self, action: #selector(handleTrashButton), for: .touchUpInside)  //cosider changing to touch down
        
        mysubviews.append(trash)
    }
    
    internal func resetTrashButton(){
        //let trashImg: UIImage? = Icon.cm.close
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
            view.deleteResumeCard(self)
        }else{
            //let trashImg: UIImage? = Icon.check
            UIView.animate(withDuration: 0.2, animations: {
                self.trash.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2))
                }, completion: { finished in
                    self.trash.transform = CGAffineTransform.identity
            })
            trash.tintColor = Color.red.base
            trashClicked = true
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if(trashClicked){
            resetTrashButton()
        }
        
    }
    
    internal func setTextBox(_ text: String, text2: String){
        let box = UITextField(frame: CGRect(x: iconSize + 20, y: 0, width: Int(self.frame.width) - iconSize - 50, height: Int(self.frame.height)/2))
        //box.backgroundColor = Color.pink.base
        box.textColor = Color.black
        box.font = RobotoFont.light(with: 16)
        box.text = text
        box.adjustsFontSizeToFitWidth = true
        mysubviews.append(box)
        
        let boxTime = UITextField(frame: CGRect(x: iconSize + 20, y: Int(self.frame.height)/2, width: Int(self.frame.width) - iconSize - 50, height: Int(self.frame.height)/2))
        //boxTime.backgroundColor = Color.green.base
        boxTime.textColor = Color.black
        boxTime.font = RobotoFont.light(with: 16)
        boxTime.text = text2
        boxTime.adjustsFontSizeToFitWidth = true
        mysubviews.append(boxTime)

    }

    internal func setIcon(){
        self.icon = Icon.menu!
        //_ = self.icon.tintWithColor(color: MainPanels.Constants.Color3)
        let iconView = UIImageView(image: self.icon)
        iconView.frame = CGRect(x: 5, y: 5, width: iconSize, height: iconSize)
        mysubviews.append(iconView)
        
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
        (textField as? ErrorTextField)?.revealError = false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }


    
        
    
}
