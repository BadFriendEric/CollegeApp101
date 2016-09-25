//
//  MainPanels.swift
//  CollegeAppFirstDraft
//
//  Created by Eric Ota on 7/25/16.
//  Copyright © 2016 College App 101. All rights reserved.
//

import UIKit
import Material
// import MainSwipeController // if using CocoaPods
class MainPanels: MainSwipeController, UIGestureRecognizerDelegate {
    
    struct Constants {
        internal static var Color1: UIColor {
            return UIColor(red:0.02, green:0.40, blue:0.55, alpha:1.0)
        }
        
        internal static var Color2: UIColor {
            return UIColor(red:0.01, green:0.50, blue:0.56, alpha:1.0)
        }
        
        internal static var Color3: UIColor {
            return UIColor(red:0.00, green:0.66, blue:0.59, alpha:1.0)
        }
        
        internal static var Color4: UIColor {
            return UIColor(red:0.01, green:0.76, blue:0.60, alpha:1.0)
        }
        
        internal static var Color5: UIColor {
            return UIColor(red:1.00, green:0.82, blue:0.25, alpha:1.0)
        }
        internal static var navBarHeight : CGFloat {
            return 40
        }
        internal static var statusBarHeight : CGFloat {
            return 20
        }

    }
    override func setupView() {
        datasource = self
    }
    
    
    let logoView : UIImageView = UIImageView(frame: CGRect(x: Int(MainSwipeController.Constants.ScreenWidth)/2-40, y: 0, width: 80, height: 50))
    let logo = UIImage(named: "logo")
    var logoAlpha = CGFloat(0)
    var titleAlpha = CGFloat(1)
    
    ///View Controllers///
    let statusBar = UIView(frame:CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: MainSwipeController.Constants.StatusBarHeight+1))
    var hubVC: UIViewController! = nil
    var coachingVC: UIViewController! = nil
    var careerVC: UIViewController! = nil
    var currentVC: UIViewController!
    var hubScrollView: UIScrollView! = UIScrollView()
    var careerFeatureView: UIView! = UIView()
    var coachingLineMid: UIView! = UIView()
    var coachingLineL1: UIView! = UIView()
    var coachingLineL2: UIView! = UIView()
    var coachingLineR1: UIView! = UIView()
    var coachingLineR2: UIView! = UIView()
    var coachingLineR3: UIView! = UIView()

    var careerFeatures: [CareerFeature]! = [CareerFeature]()
    var coachingFeatureView: UIView! = UIView()
    //var coachingFeatures: [CoachingPreview]! = [CoachingPreview]()
    var menu: MenuVC! = MenuVC()
    var hubCards: [HubCard] = []
    var coachingPreviewGeneral : CoachingPreview! = CoachingPreview()
    var coachingPreviewWriting : CoachingPreview! = CoachingPreview()
    var coachingPreviewEvaluation : CoachingPreview! = CoachingPreview()
    var coachingPreviewFreshman : CoachingPreview! = CoachingPreview()
    var coachingPreviewSophomore : CoachingPreview! = CoachingPreview()
    var coachingPreviewJunior : CoachingPreview! = CoachingPreview()
    var coachingPreviewSenior : CoachingPreview! = CoachingPreview()

    var navBarHighlightColor = Color.black
    let navColor = Color.grey.lighten2
    
    
    ///Navigation Bar Variables///
    let navBar: NavigationBar = NavigationBar(frame: CGRect(origin:CGPoint(x: 0,y: MainSwipeController.Constants.StatusBarHeight),size:CGSize(width: Constants.ScreenWidth,height: 50)))
    let navItem: UINavigationItem = UINavigationItem()
    fileprivate var menuButton: UIImageView!
    fileprivate var helpButton: UIImageView!
    fileprivate var menuButtonView : UIView! = UIView()
    fileprivate var helpButtonView : UIView! = UIView()
    fileprivate var midButtonView : UIView! = UIView()
    fileprivate let buttonWidths = 75
    
    
    ///Size Constants///
    let width = MainSwipeController.Constants.ScreenWidth
    let height = MainSwipeController.Constants.ScreenHeight
    //private var navBarHeight = 50
    fileprivate var hubCardBottom = Int(Constants.navBarHeight) + 15
    fileprivate var hubCardSpacing = 20

    
    /////////////////////////////////////////////////
    //---------------Prepare Methods---------------//
    /////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        prepareNavigationBar()
        prepareHelpButton()
        prepareMenuButton()
        prepareMenu()
        prepareNavigationItem()
        
        prepareHubScrollView()
        prepareCareerView()
        prepareCoachView()
        
        let c = addCard(hubCardBottom, size: 110, vc: hubScrollView)
        c.type = "Default"
        refreshHubCards()
    
    }
    fileprivate func prepareView(){
        view.backgroundColor = Color.grey.lighten2
        
        
    }
    fileprivate func prepareHelpButton(){
        let helpButtonImage: UIImage? = UIImage(named: "HelpIcon")
        let imageSize = CGSize(width: 30, height: 30)
        _ = MainPanels.ResizeImage(helpButtonImage!, targetSize: imageSize)
        helpButton = UIImageView(image: helpButtonImage)
        helpButton.frame = CGRect(origin: CGPoint(x: navBar.width-45, y: 7), size: imageSize)
        helpButtonView.frame = CGRect(x: Int(navBar.width) - buttonWidths, y: 0, width: buttonWidths, height: Int(Constants.navBarHeight))
    }
    fileprivate func prepareMenuButton(){
        let menuButtonImage: UIImage? = UIImage(named: "MenuIcon")
        let imageSize = CGSize(width: 25, height: 25)
        _ = MainPanels.ResizeImage(menuButtonImage!, targetSize: imageSize)
        menuButton = UIImageView(image: menuButtonImage)
        menuButton.frame = CGRect(origin: CGPoint(x: 15, y: 10), size: imageSize)
        menuButtonView.frame = CGRect(x: 0, y: 0, width: buttonWidths, height: Int(Constants.navBarHeight))
    }
    fileprivate func prepareNavigationItem(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMenuButton))
        tap.delegate = self
        menuButtonView.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(handleHelpButton))
        tap1.delegate = self
        helpButtonView.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleMidButton))
        tap2.delegate = self
        midButtonView.addGestureRecognizer(tap2)
        
        
        //print(menuButton.frame.minY)
        
        navBar.addSubview(menuButton)
        navBar.addSubview(helpButton)
        
        navBar.addSubview(menuButtonView)
        navBar.addSubview(helpButtonView)
        navBar.addSubview(midButtonView)
        
        refreshTitle("The Hub")
        
        
    }
    fileprivate func prepareNavigationBar(){
        //let navBgImage:UIImage = UIImage(named: "NavBarBackground")!
        //let navTexture = UIColor(patternImage: navBgImage)
        statusBar.backgroundColor = navColor
        navBar.backgroundColor = navColor

        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        self.view.addGestureRecognizer(gesture)

        
//        navItem.leftControls = [menuButton]
//        navItem.rightControls = [helpButton]
        navBar.setItems([navItem], animated: false)
        
        
        midButtonView.frame = CGRect(x: (Int(MainSwipeController.Constants.ScreenWidth)-buttonWidths)/2, y: 0, width: buttonWidths, height: Int(Constants.navBarHeight))
        
        
        
        self.view.addSubview(navBar)
        self.view.addSubview(statusBar)
        
        
    }
    fileprivate func prepareMenu(){
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapView))
        menu.menuBacker.addGestureRecognizer(gesture)
    }
    
    ///Prepare Hub Panel///
    fileprivate func prepareHubScrollView(){
        hubScrollView.frame = CGRect(x: 0, y: Constants.navBarHeight, width: navBar.width, height: hubVC.view.frame.height-Constants.navBarHeight)
        
        hubVC.view.addSubview(hubScrollView)
        
        //self.addChildViewController(menu)
    }
   
    ///Prepare Career Panel///
    internal func prepareCareerView(){
        careerFeatureView.frame = CGRect(x: 0, y: Constants.navBarHeight+Constants.statusBarHeight, width: navBar.width, height: careerVC.view.frame.height-Constants.navBarHeight-Constants.statusBarHeight)
        let cf1: CareerFeature = CareerFeatureTopSchools()
        let cf2: CareerFeature = CareerFeatureResumeBuilder()
        let cf3: CareerFeature = CareerFeature()
        let cf4: CareerFeature = CareerFeature()
        let cf5: CareerFeature = CareerFeature()
        careerFeatures.append(cf1)
        careerFeatures.append(cf2)
        careerFeatures.append(cf3)
        careerFeatures.append(cf4)
        careerFeatures.append(cf5)
        
        let numFeatures = careerFeatures.count
        
        for n in 0..<numFeatures {
            let cf = careerFeatures[n]
            cf.superView(careerFeatureView)
            cf.myVC(self)
            cf.setFrame(0, y: (Int(careerFeatureView.frame.height)/numFeatures+1)*(n),
                        width: Int(careerFeatureView.frame.width),
                        height: Int(careerFeatureView.frame.height)/numFeatures+1)
            careerFeatureView.addSubview(cf.view)
        }
        cf1.setColor(Color.blue.lighten1)
        cf2.setColor(Color.blue.darken1)
        cf3.setColor(Color.blue.lighten1)
        cf4.setColor(Color.blue.darken1)
        cf5.setColor(Color.blue.lighten1)
        cf3.setFeatureTitle("Reminders")
        cf4.setFeatureTitle("Volunteer Match")
        cf5.setFeatureTitle("Essay Planner")

        careerVC.view.addSubview(careerFeatureView)
        
    }
    
    ///Prepare Coach Panel///
    internal func prepareCoachView(){
        coachingPreviewGeneral.superview = coachingVC
        coachingPreviewWriting.superview = coachingVC
        coachingPreviewEvaluation.superview = coachingVC
        coachingPreviewFreshman.superview = coachingVC
        coachingPreviewSophomore.superview = coachingVC
        coachingPreviewJunior.superview = coachingVC
        coachingPreviewSenior.superview  = coachingVC
        
        let freshmanColor = UIColor(red:0.79, green:0.95, blue:0.98, alpha:1.0)
        let sophomoreColor = UIColor(red:0.43, green:0.85, blue:0.96, alpha:1.0)
        let juniorColor = UIColor(red:0.01, green:0.76, blue:0.92, alpha:1.0)
        let seniorColor = UIColor(red:0.00, green:0.59, blue:0.73, alpha:1.0)
        let writingColor = UIColor(red:0.87, green:0.91, blue:0.78, alpha:1.0)
        let generalColor = UIColor(red:0.73, green:0.81, blue:0.50, alpha:1.0)
        let evaluationColor = UIColor(red:0.59, green:0.76, blue:0.18, alpha:1.0)
        
        coachingPreviewGeneral.setCoachingName("General")
        coachingPreviewWriting.setCoachingName("Writing")
        coachingPreviewEvaluation.setCoachingName("Evaluation")
        coachingPreviewFreshman.setCoachingName("Freshman")
        coachingPreviewSophomore.setCoachingName("Sophomore")
        coachingPreviewJunior.setCoachingName("Junior")
        coachingPreviewSenior.setCoachingName("Senior")
        
        
        coachingPreviewGeneral.setBackgroundColor(generalColor)
        coachingPreviewWriting.setBackgroundColor(writingColor)
        coachingPreviewEvaluation.setBackgroundColor(evaluationColor)
        coachingPreviewFreshman.setBackgroundColor(freshmanColor)
        coachingPreviewSophomore.setBackgroundColor(sophomoreColor)
        coachingPreviewJunior.setBackgroundColor(juniorColor)
        coachingPreviewSenior.setBackgroundColor(seniorColor)
        
        
        let titleColor: UIColor! = Color.black
        
        
        let h = height - 70
        
        let writing: FlatButton = FlatButton(frame: CGRect(x: 0, y: 70, width: coachingVC.view.frame.width/2, height: h/3))
        writing.setTitleColor(titleColor, for: UIControlState())
        writing.setTitle("Writing", for: UIControlState())
        writing.cornerRadius = 0
        writing.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        //writing.backgroundColor = Color.red.lighten1
        writing.backgroundColor = writingColor
        writing.addTarget(self, action: #selector(handleCoachingWritingButton), for: .touchDown)
        coachingVC.view.addSubview(writing)
        
        let general: FlatButton = FlatButton(frame: CGRect(x: 0, y: 70 + h/3, width: coachingVC.view.frame.width/2, height: h/3))
        general.setTitleColor(titleColor, for: UIControlState())
        general.setTitle("General", for: UIControlState())
        general.backgroundColor = generalColor
        general.cornerRadius = 0
        general.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        general.addTarget(self, action: #selector(handleCoachingGeneralButton), for: .touchDown)
        coachingVC.view.addSubview(general)
        
        let evaluation: FlatButton = FlatButton(frame: CGRect(x: 0, y: 70 + 2*(h/3), width: coachingVC.view.frame.width/2, height: h/3))
        evaluation.setTitleColor(titleColor, for: UIControlState())
        evaluation.setTitle("Evaluation", for: UIControlState())
        evaluation.cornerRadius = 0
        evaluation.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        evaluation.backgroundColor = evaluationColor
        evaluation.addTarget(self, action: #selector(handleCoachingEvaluationButton), for: .touchDown)
        coachingVC.view.addSubview(evaluation)
        
        let freshman: FlatButton = FlatButton(frame: CGRect(x: width/2, y: 70, width: coachingVC.view.frame.width/2, height: h/4))
        freshman.setTitleColor(titleColor, for: UIControlState())
        freshman.setTitle("Freshman", for: UIControlState())
        freshman.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        freshman.cornerRadius = 0
        //freshman.backgroundColor = Color.purple.lighten2
        freshman.backgroundColor = freshmanColor
        freshman.addTarget(self, action: #selector(handleCoachingFreshmanButton), for: .touchDown)
        coachingVC.view.addSubview(freshman)
        
        let sophomore: FlatButton = FlatButton(frame: CGRect(x: width/2, y: 70 + (h/4), width: coachingVC.view.frame.width/2, height: h/4))
        sophomore.setTitleColor(titleColor, for: UIControlState())
        sophomore.setTitle("Sophomore", for: UIControlState())
        sophomore.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        sophomore.cornerRadius = 0
        //sophomore.backgroundColor = Color.teal.lighten2
        sophomore.backgroundColor = sophomoreColor
        sophomore.addTarget(self, action: #selector(handleCoachingSophomoreButton), for: .touchDown)
        coachingVC.view.addSubview(sophomore)

        let junior: FlatButton = FlatButton(frame: CGRect(x: width/2, y: 70 + 2*(h/4), width: coachingVC.view.frame.width/2, height: h/4))
        junior.setTitleColor(titleColor, for: UIControlState())
        junior.setTitle("Junior", for: UIControlState())
        junior.cornerRadius = 0
        junior.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        //junior.backgroundColor = Color.pink.lighten2
        junior.backgroundColor = juniorColor
        junior.addTarget(self, action: #selector(handleCoachingJuniorButton), for: .touchDown)
        coachingVC.view.addSubview(junior)

        let senior: FlatButton = FlatButton(frame: CGRect(x: width/2, y: 70 + 3*(h/4), width: coachingVC.view.frame.width/2, height: h/4))
        senior.setTitleColor(titleColor, for: UIControlState())
        senior.setTitle("Senior", for: UIControlState())
        senior.cornerRadius = 0
        senior.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        //senior.backgroundColor = Color.cyan.lighten2
        senior.backgroundColor = seniorColor
        senior.addTarget(self, action: #selector(handleCoachingSeniorButton), for: .touchDown)
        coachingVC.view.addSubview(senior)

        
        let lineColor : UIColor = Color.black
        
        coachingLineMid = UIView(frame: CGRect(x: width/2,y: 70 ,width: 2,height: h))
        coachingLineMid.layer.borderWidth = 0
        coachingLineMid.backgroundColor = lineColor
        coachingLineMid.alpha = 1
        coachingVC.view.addSubview(coachingLineMid)
        
        coachingLineL1 = UIView(frame: CGRect(x: 0,y: 70 + (h/3) ,width: (width/2) ,height: 2))
        coachingLineL1.layer.borderWidth = 0
        coachingLineL1.backgroundColor = lineColor
        coachingLineL1.alpha = 1
        coachingVC.view.addSubview(coachingLineL1)
        
        coachingLineL2 = UIView(frame: CGRect(x: 0,y: 70 + 2*(h/3) ,width: (width/2),height: 2))
        coachingLineL2.layer.borderWidth = 0
        coachingLineL2.layer.borderColor = UIColor.white.cgColor
        coachingLineL2.backgroundColor = lineColor
        coachingLineL2.alpha = 1
        coachingVC.view.addSubview(coachingLineL2)
        
        coachingLineR1 = UIView(frame: CGRect(x: width/2,y: 70 + (h/4),width: (width/2),height: 2))
        coachingLineR1.layer.borderWidth = 0
        coachingLineR1.layer.borderColor = UIColor.white.cgColor
        coachingLineR1.backgroundColor = lineColor
        coachingLineR1.alpha = 1
        coachingVC.view.addSubview(coachingLineR1)
        
        coachingLineR2 = UIView(frame: CGRect(x: width/2,y: 70 + 2*(h/4),width: (width/2),height: 2))
        coachingLineR2.layer.borderWidth = 0
        coachingLineR2.layer.borderColor = UIColor.white.cgColor
        coachingLineR2.backgroundColor = lineColor
        coachingLineR2.alpha = 1
        coachingVC.view.addSubview(coachingLineR2)
        
        coachingLineR3 = UIView(frame: CGRect(x: width/2,y: 70 + 3*(h/4),width: (width/2),height: 2))
        coachingLineR3.layer.borderWidth = 0
        coachingLineR3.layer.borderColor = UIColor.white.cgColor
        coachingLineR3.backgroundColor = lineColor
        coachingLineR3.alpha = 1
        coachingVC.view.addSubview(coachingLineR3)
        


    }
    
    
    /////////////////////////////////////////////////
    //---------------Refresh Methods---------------//
    /////////////////////////////////////////////////
    
    
    internal func refreshTitle(_ title: String){
        
        //navItem.titleLabel.frame = CGRect(x: Int(navBar.frame.width/2)-buttonWidths, y: 15, width: buttonWidths, height: 70)
        navBar.contentEdgeInsets = UIEdgeInsets.zero
        navItem.title = title
        //navItem.titleLabel.clipsToBounds = false
        navItem.titleLabel.textAlignment = .center
        navItem.titleLabel.font = UIFont(name: "Oswald", size: 32)
        navItem.titleLabel.textColor = navBarHighlightColor
        UIView.animate(withDuration: 0.5, animations: {
            }, completion: { finished in
                self.refreshNavBar()
        })
        
    }
   
    fileprivate func refreshScrollView(_ height: Int){
        UIView.animate(withDuration: 0.3, animations: {
            self.hubScrollView.contentSize.height = CGFloat(height)
        })
    }
    internal func refreshHubCards(){
        var currentCardPos = Int(Constants.navBarHeight) + hubCardSpacing - 5
        for card in hubCards{
            if(Int(card.y) > currentCardPos){
                UIView.animate(withDuration: 0.3, animations: {
                    card.y = CGFloat(currentCardPos)
                    })
            }
            currentCardPos = Int(card.y) + Int(card.height) + hubCardSpacing
        }
        if(hubCards.isEmpty){
            hubCardBottom = Int(Constants.navBarHeight) + hubCardSpacing - 5
        }else{
            hubCardBottom = Int((hubCards.last?.y)!) + Int((hubCards.last?.height)!) + hubCardSpacing
        }
        self.refreshScrollView(self.hubCardBottom)
    }
    internal func refreshNavBar(){
        navBar.removeFromSuperview()
        statusBar.removeFromSuperview()
        view.addSubview(statusBar)
        view.addSubview(navBar)
        
        if(menu.open){
            menu.refreshMenu(self.view)

        }
        menuButtonView.removeFromSuperview()
        navBar.addSubview(menuButtonView)
        helpButtonView.removeFromSuperview()
        navBar.addSubview(helpButtonView)
        midButtonView.removeFromSuperview()
        navBar.addSubview(midButtonView)
    }
    
    
    /////////////////////////////////////////////////
    //---------Button and Touch Handlers-----------//
    /////////////////////////////////////////////////
    
    
    internal func handleMenuButton(){
        menu.removeFromParentViewController()
        self.addChildViewController(menu)
        menu.slideIn(self.view)
    }
    
    internal func handleHelpButton(){
        let size = 110
        _ = addCard(hubCardBottom,size: size,vc: hubScrollView)
        
        if(hubCardBottom > Int(hubVC.view.frame.height)){
            refreshScrollView(hubCardBottom)
        }
    }
    internal func handleMidButton(){
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.logoView.alpha = 0
            self.moveToPage(1)
            }, completion: { finished in
                self.logoView.alpha = 0
        })
    }
    
    
    @objc func tapView(_ sender: UITapGestureRecognizer){
        if(menu.open){
            menu.slideOut()
        }
    }
    @objc fileprivate func handleCoachingGeneralButton(){
        view.addSubview(coachingPreviewGeneral.view)
        refreshNavBar()
        coachingPreviewGeneral.pushDownVC(coachingVC, dur: 0.5)
        //self.addChildViewController(self)
    }
    
    @objc fileprivate func handleCoachingWritingButton(){
        view.addSubview(coachingPreviewWriting.view)  //Change to writing
        refreshNavBar()
        coachingPreviewWriting.pushDownVC(coachingVC, dur: 0.5)  //writing
    }
    
    @objc fileprivate func handleCoachingEvaluationButton(){
        view.addSubview(coachingPreviewEvaluation.view)  //Change to evaluation
        refreshNavBar()
        coachingPreviewEvaluation.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }
    
    @objc fileprivate func handleCoachingFreshmanButton(){
        view.addSubview(coachingPreviewFreshman.view)  //Change to freshman
        refreshNavBar()
        coachingPreviewFreshman.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }
    
    @objc fileprivate func handleCoachingSophomoreButton(){
        view.addSubview(coachingPreviewSophomore.view)  //Change to sophomiore lol lololool (lol -sam)
        refreshNavBar()
        coachingPreviewSophomore.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }

    @objc fileprivate func handleCoachingJuniorButton(){
        view.addSubview(coachingPreviewJunior.view)  //Change to freshman
        refreshNavBar()
        coachingPreviewJunior.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }

    @objc fileprivate func handleCoachingSeniorButton(){
        view.addSubview(coachingPreviewSenior.view)  //Change to freshman
        refreshNavBar()
        
        coachingPreviewSenior.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    func handleSwipes(_ sender: UISwipeGestureRecognizer){
        if(sender.direction == .left || sender.direction == .right) {
            UIView.animate(withDuration: 0.3, animations: {
                self.navItem.titleLabel.alpha = 0
            })
        }
    }
    override func handleStartMove() {
        UIView.animate(withDuration: 0.5, animations: {
            self.navItem.titleLabel.alpha = 0
        })
    }
    override func handleEndMove(){
        UIView.animate(withDuration: 0.5, animations: {
            self.navItem.titleLabel.alpha = 1
        })
    }
    override func handleEndMoveSamePage() {
        UIView.animate(withDuration: 0.5, animations: {
            self.navItem.titleLabel.alpha = 1
        })
    }
    
    
    ////////////////////////////////////////////////
    //--------------The Hub Methods---------------//
    ////////////////////////////////////////////////
    
    internal func addCard(_ y: Int, size: Int, vc: UIScrollView) -> HubCard{
        let card: HubCard = HubCard(vc: self,type: "Default",x: 20, y: y, width: Int(Constants.ScreenWidth-40),height: size)
        hubCardBottom += size+hubCardSpacing
        hubCards.append(card)
        vc.addSubview(card)
        return card
    }
    internal func deleteHubCard(_ card: HubCard){
        card.removeFromSuperview()
        hubCards.remove(at: hubCards.index(of: card)!)
        refreshHubCards()
    }
    

    
    /////////////////////////////////////////////////
    //--------------Coaching Methods---------------//
    /////////////////////////////////////////////////
    
    
    
    
    
    
    
    ///////////////////////////////////////////////
    //--------------Career Methods---------------//
    ///////////////////////////////////////////////

    
    static func ResizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
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
        UIGraphicsGetCurrentContext()!.interpolationQuality = CGInterpolationQuality.low
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

/////////////////////////////////////////////////
//----------------Extension--------------------//
/////////////////////////////////////////////////


extension MainPanels: MainSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        
        let coachingColor = Color.white.cgColor
        let careerColor = Color.white.cgColor
        let hubColor = UIColor(red:1.00, green:0.90, blue:0.60, alpha:1.0).cgColor

        
        let coachingVC = UIViewController()
        coachingVC.view.layer.backgroundColor = coachingColor
        //coachingVC.view.layer.addSublayer(getGradient1())
        
        let hubVC = UIViewController()
        hubVC.view.layer.backgroundColor = hubColor
        //hubVC.view.layer.addSublayer(getGradient2())
        
        let careerVC = UIViewController()
        careerVC.view.layer.backgroundColor = careerColor
        //careerVC.view.layer.addSublayer(getGradient3())
        
        
        self.hubVC = hubVC
        self.careerVC = careerVC
        self.coachingVC = coachingVC
        self.currentVC = hubVC
        
        return [coachingVC, hubVC, careerVC]
    }
    
    
    func getGradient1() -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [Color.blue.base.cgColor, Color.blue.lighten2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    func getGradient2() -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [Color.lightGreen.darken1.cgColor, Color.lightGreen.lighten1.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    func getGradient3() -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [Constants.Color3.cgColor, Constants.Color4.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    func indexOfStartingPage() -> Int {
        return 1
    }
    
    func changedToPageIndex(_ index: Int) {
        refreshTitle(titlesForPages()[index])
        self.currentVC = stackPageVC[index]
    }
    
    func titlesForPages() -> [String] {
        return ["Coaching", "The Hub", "Planner"]
    }
}
