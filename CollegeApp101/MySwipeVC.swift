//
//  MySwipeVC.swift
//  CollegeAppFirstDraft
//
//  Created by Eric Ota on 7/25/16.
//  Copyright © 2016 College App 101. All rights reserved.
//

import UIKit
import Material
// import EZSwipeController // if using CocoaPods
class MySwipeVC: EZSwipeController {
    
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
            return 50
        }
        internal static var navBarHeightWithStatusBar : CGFloat {
            return 70
        }

    }
    override func setupView() {
        datasource = self
    }
    
    
    
    
    ///View Controllers///
    let statusBar = UIView(frame:CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: EZSwipeController.Constants.StatusBarHeight+1))
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
    var coachingFeatures: [CoachingPreviewGeneral]! = [CoachingPreviewGeneral]()
    var menu: MenuVC! = MenuVC()
    var hubCards: [HubCard] = []
    var coachingPreviewGeneral : CoachingPreviewGeneral! = CoachingPreviewGeneral()
    var coachingPreviewWriting : CoachingPreviewWriting! = CoachingPreviewWriting()
    var coachingPreviewEvaluation : CoachingPreviewEvaluation! = CoachingPreviewEvaluation()
    var coachingPreviewFreshman : CoachingPreviewFreshman! = CoachingPreviewFreshman()
    var coachingPreviewSophomore : CoachingPreviewSophomore! = CoachingPreviewSophomore()
    var coachingPreviewJunior : CoachingPreviewJunior! = CoachingPreviewJunior()
    var coachingPreviewSenior : CoachingPreviewSenior! = CoachingPreviewSenior()

    var navBarHighlightColor = MaterialColor.black
    var navColor = MaterialColor.white
    
    
    ///Navigation Bar Variables///
    let navBar: NavigationBar = NavigationBar(frame: CGRect(origin:CGPoint(x: 0,y: EZSwipeController.Constants.StatusBarHeight),size:CGSizeMake(Constants.ScreenWidth,50)))
    let navItem: UINavigationItem = UINavigationItem()
    private var menuButton: IconButton!
    private var helpButton: IconButton!
    
    
    
    ///Size Constants///
    let width = EZSwipeController.Constants.ScreenWidth
    let height = EZSwipeController.Constants.ScreenHeight
    //private var navBarHeight = 50
    private var hubCardBottom = 50
    private var hubCardSpacing = 25

    
    /////////////////////////////////////////////////
    //---------------Prepare Methods---------------//
    /////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        prepareHelpButton()
        prepareMenuButton()
        prepareNavigationItem()
        prepareNavigationBar()
        prepareMenu()
        prepareHubScrollView()
        prepareCareerView()
        prepareCoachView()
    
    }
    private func prepareView(){
        view.backgroundColor = MaterialColor.grey.lighten2
        
        
    }
    private func prepareHelpButton(){
        let helpButtonImage: UIImage? = UIImage(named: "HelpIcon")
        helpButton = IconButton()
        helpButton.pulseColor = navBarHighlightColor
        helpButton.tintColor = navBarHighlightColor
        helpButton.setImage(helpButtonImage, forState: .Normal)
        helpButton.setImage(helpButtonImage, forState: .Highlighted)
        helpButton.addTarget(self, action: #selector(handleHelpButton), forControlEvents: .TouchUpInside)
    }
    private func prepareMenuButton(){
        let menuButtonImage: UIImage? = UIImage(named: "MenuIcon")
        menuButton = IconButton()
        
        menuButton.imageEdgeInsets.top = 8
        menuButton.imageEdgeInsets.left = 8
        menuButton.imageEdgeInsets.right = 8
        menuButton.imageEdgeInsets.bottom = 8
        
        menuButton.pulseColor = navBarHighlightColor
        menuButton.tintColor = navBarHighlightColor
        
        menuButton.setImage(menuButtonImage, forState: .Normal)
        menuButton.setImage(menuButtonImage, forState: .Highlighted)
        menuButton.addTarget(self, action: #selector(handleMenuButton), forControlEvents: .TouchUpInside)
        
    }
    private func prepareNavigationItem(){
        resfreshTitle("The Hub")
    }
    private func prepareNavigationBar(){
        navigationController?.navigationBar.statusBarStyle = .Default
        
        let navBgImage:UIImage = UIImage(named: "NavBarBackground")!
        let navTexture = UIColor(patternImage: navBgImage)
        statusBar.backgroundColor = navTexture
        
        navBar.contentInset.left = 15
        navBar.contentInset.right = 10
        navBar.backgroundColor = navTexture        
        
        //navBar.setBackgroundImage(navBgImage, forBarMetrics: .Default)
        
        
        navBar.setItems([navItem], animated: false)
        navItem.leftControls = [menuButton]
        navItem.rightControls = [helpButton]
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        self.view.addGestureRecognizer(gesture)

        self.view.addSubview(navBar)
        self.view.addSubview(statusBar)
        
        
    }
    private func prepareMenu(){
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapView))
        menu.menuBacker.addGestureRecognizer(gesture)
    }
    
    ///Prepare Hub Panel///
    private func prepareHubScrollView(){
        hubScrollView.frame = CGRect(x: 0, y: navBar.height, width: navBar.width, height: hubVC.view.frame.height-navBar.height)
        
        hubVC.view.addSubview(hubScrollView)
    }
   
    ///Prepare Career Panel///
    internal func prepareCareerView(){
        careerFeatureView.frame = CGRect(x: 0, y: navBar.height+20, width: navBar.width, height: hubVC.view.frame.height-navBar.height-20)
        let cf1: CareerFeature = CareerFeaturePlanner()
        let cf2: CareerFeature = CareerFeatureResumeBuilder()
        let cf3: CareerFeature = CareerFeature()
        //let cf4: CareerFeature = CareerFeature()
        careerFeatures.append(cf1)
        careerFeatures.append(cf2)
        careerFeatures.append(cf3)
        //careerFeatures.append(cf4)
        
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
        cf3.setFeatureTitle("Volunteer Match")
        cf1.setColor(MaterialColor.blue.lighten1)
        cf2.setColor(MaterialColor.lightGreen.lighten1)
        cf3.setColor(MaterialColor.purple.lighten2)
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
        
        let freshmanColor = MaterialColor.green.lighten2
        let sophomoreColor = MaterialColor.orange.lighten2
        let juniorColor = MaterialColor.blue.lighten2
        let seniorColor = MaterialColor.red.lighten2
        let writingColor = MaterialColor.cyan.lighten2
        let generalColor = MaterialColor.purple.lighten2
        let evaluationColor = MaterialColor.lightGreen.lighten2
        
        let h = height - 70
        
        let writing: FlatButton = FlatButton(frame: CGRect(x: 0, y: 70, width: coachingVC.view.frame.width/2, height: h/3))
        writing.setTitleColor(MaterialColor.white, forState: .Normal)
        writing.setTitle("Writing", forState: .Normal)
        writing.cornerRadius = 0
        writing.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        //writing.backgroundColor = MaterialColor.red.lighten1
        writing.backgroundColor = writingColor
        writing.addTarget(self, action: #selector(handleCoachingWritingButton), forControlEvents: .TouchDown)
        coachingVC.view.addSubview(writing)
        
        let general: FlatButton = FlatButton(frame: CGRect(x: 0, y: 70 + h/3, width: coachingVC.view.frame.width/2, height: h/3))
        general.setTitleColor(MaterialColor.white, forState: .Normal)
        general.setTitle("General", forState: .Normal)
        general.backgroundColor = generalColor
        general.cornerRadius = 0
        general.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        general.addTarget(self, action: #selector(handleCoachingGeneralButton), forControlEvents: .TouchDown)
        coachingVC.view.addSubview(general)
        
        let evaluation: FlatButton = FlatButton(frame: CGRect(x: 0, y: 70 + 2*(h/3), width: coachingVC.view.frame.width/2, height: h/3))
        evaluation.setTitleColor(MaterialColor.white, forState: .Normal)
        evaluation.setTitle("Evaluation", forState: .Normal)
        evaluation.cornerRadius = 0
        evaluation.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        evaluation.backgroundColor = evaluationColor
        evaluation.addTarget(self, action: #selector(handleCoachingEvaluationButton), forControlEvents: .TouchDown)
        coachingVC.view.addSubview(evaluation)
        
        let freshman: FlatButton = FlatButton(frame: CGRect(x: width/2, y: 70, width: coachingVC.view.frame.width/2, height: h/4))
        freshman.setTitleColor(MaterialColor.white, forState: .Normal)
        freshman.setTitle("Freshman", forState: .Normal)
        freshman.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        freshman.cornerRadius = 0
        //freshman.backgroundColor = MaterialColor.purple.lighten2
        freshman.backgroundColor = freshmanColor
        freshman.addTarget(self, action: #selector(handleCoachingFreshmanButton), forControlEvents: .TouchDown)
        coachingVC.view.addSubview(freshman)
        
        let sophomore: FlatButton = FlatButton(frame: CGRect(x: width/2, y: 70 + (h/4), width: coachingVC.view.frame.width/2, height: h/4))
        sophomore.setTitleColor(MaterialColor.white, forState: .Normal)
        sophomore.setTitle("Sophomore", forState: .Normal)
        sophomore.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        sophomore.cornerRadius = 0
        //sophomore.backgroundColor = MaterialColor.teal.lighten2
        sophomore.backgroundColor = sophomoreColor
        sophomore.addTarget(self, action: #selector(handleCoachingSophomoreButton), forControlEvents: .TouchDown)
        coachingVC.view.addSubview(sophomore)

        let junior: FlatButton = FlatButton(frame: CGRect(x: width/2, y: 70 + 2*(h/4), width: coachingVC.view.frame.width/2, height: h/4))
        junior.setTitleColor(MaterialColor.white, forState: .Normal)
        junior.setTitle("Junior", forState: .Normal)
        junior.cornerRadius = 0
        junior.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        //junior.backgroundColor = MaterialColor.pink.lighten2
        junior.backgroundColor = juniorColor
        junior.addTarget(self, action: #selector(handleCoachingJuniorButton), forControlEvents: .TouchDown)
        coachingVC.view.addSubview(junior)

        let senior: FlatButton = FlatButton(frame: CGRect(x: width/2, y: 70 + 3*(h/4), width: coachingVC.view.frame.width/2, height: h/4))
        senior.setTitleColor(MaterialColor.white, forState: .Normal)
        senior.setTitle("Senior", forState: .Normal)
        senior.cornerRadius = 0
        senior.titleLabel?.font = UIFont(name: "Scope One", size: 24)
        //senior.backgroundColor = MaterialColor.cyan.lighten2
        senior.backgroundColor = seniorColor
        senior.addTarget(self, action: #selector(handleCoachingSeniorButton), forControlEvents: .TouchDown)
        coachingVC.view.addSubview(senior)

        
        coachingLineMid = UIView(frame: CGRect(x: width/2,y: 70 ,width: 2,height: h))
        coachingLineMid.layer.borderWidth = 0
        coachingLineMid.backgroundColor = MaterialColor.white
        coachingLineMid.alpha = 1
        coachingVC.view.addSubview(coachingLineMid)
        
        coachingLineL1 = UIView(frame: CGRect(x: 0,y: 70 + (h/3) ,width: (width/2) ,height: 2))
        coachingLineL1.layer.borderWidth = 0
        coachingLineL1.backgroundColor = MaterialColor.white
        coachingLineL1.alpha = 1
        coachingVC.view.addSubview(coachingLineL1)
        
        coachingLineL2 = UIView(frame: CGRect(x: 0,y: 70 + 2*(h/3) ,width: (width/2),height: 2))
        coachingLineL2.layer.borderWidth = 0
        coachingLineL2.layer.borderColor = UIColor.whiteColor().CGColor
        coachingLineL2.backgroundColor = MaterialColor.white
        coachingLineL2.alpha = 1
        coachingVC.view.addSubview(coachingLineL2)
        
        coachingLineR1 = UIView(frame: CGRect(x: width/2,y: 70 + (h/4),width: (width/2),height: 2))
        coachingLineR1.layer.borderWidth = 0
        coachingLineR1.layer.borderColor = UIColor.whiteColor().CGColor
        coachingLineR1.backgroundColor = MaterialColor.white
        coachingLineR1.alpha = 1
        coachingVC.view.addSubview(coachingLineR1)
        
        coachingLineR2 = UIView(frame: CGRect(x: width/2,y: 70 + 2*(h/4),width: (width/2),height: 2))
        coachingLineR2.layer.borderWidth = 0
        coachingLineR2.layer.borderColor = UIColor.whiteColor().CGColor
        coachingLineR2.backgroundColor = MaterialColor.white
        coachingLineR2.alpha = 1
        coachingVC.view.addSubview(coachingLineR2)
        
        coachingLineR3 = UIView(frame: CGRect(x: width/2,y: 70 + 3*(h/4),width: (width/2),height: 2))
        coachingLineR3.layer.borderWidth = 0
        coachingLineR3.layer.borderColor = UIColor.whiteColor().CGColor
        coachingLineR3.backgroundColor = MaterialColor.white
        coachingLineR3.alpha = 1
        coachingVC.view.addSubview(coachingLineR3)
        


    }
    
    
    /////////////////////////////////////////////////
    //---------------Refresh Methods---------------//
    /////////////////////////////////////////////////
    
    
    internal func resfreshTitle(title: String){
        navItem.title = title
        navItem.titleLabel.textAlignment = .Center
        navItem.titleLabel.font = UIFont(name: "Vesper Libre", size: 32)
        navItem.titleLabel.textColor = navBarHighlightColor
        navBar.setItems([navItem], animated: false)
        
        UIView.animateWithDuration(0.5, animations: {
            self.navItem.titleLabel.alpha = 1
            self.navBar.removeFromSuperview()
            self.view.addSubview(self.navBar)
        })
    }
    private func refreshScrollView(height: Int){
        UIView.animateWithDuration(0.3, animations: {
            self.hubScrollView.contentSize.height = CGFloat(height)
        })
    }
    internal func refreshHubCards(){
        //print("refresh")
        var currentCardPos = Int(Constants.navBarHeight)
        for card in hubCards{
            if(Int(card.y) > currentCardPos){
                UIView.animateWithDuration(0.3, animations: {
                    card.y = CGFloat(currentCardPos)
                    })
            }
            currentCardPos = Int(card.y) + Int(card.height) + hubCardSpacing
        }
        if(hubCards.isEmpty){
            hubCardBottom = Int(Constants.navBarHeight)
        }else{
            hubCardBottom = Int((hubCards.last?.y)!) + Int((hubCards.last?.height)!) + hubCardSpacing
        }
        self.refreshScrollView(self.hubCardBottom)
    }
    internal func refreshNavBar(){
        navBar.removeFromSuperview()
        view.addSubview(navBar)
        statusBar.removeFromSuperview()
        view.addSubview(statusBar)
    }
    
    
    /////////////////////////////////////////////////
    //---------Button and Touch Handlers-----------//
    /////////////////////////////////////////////////
    
    
    internal func handleMenuButton(){
        menu.slideIn(self.view)
    }
    
    internal func handleHelpButton(){
        let size = 110
        addCard(hubCardBottom,size: size,vc: hubScrollView)
        hubCardBottom += size+hubCardSpacing
        if(hubCardBottom > Int(hubVC.view.frame.height)){
            refreshScrollView(hubCardBottom)
        }
    }
    
    
    @objc func tapView(sender: UITapGestureRecognizer){
        if(menu.open){
            menu.slideOut()
        }
    }
    @objc private func handleCoachingGeneralButton(){
        view.addSubview(coachingPreviewGeneral.view)
        refreshNavBar()
        coachingPreviewGeneral.pushDownVC(coachingVC, dur: 0.5)
    }
    
    @objc private func handleCoachingWritingButton(){
        view.addSubview(coachingPreviewWriting.view)  //Change to writing
        refreshNavBar()
        coachingPreviewWriting.pushDownVC(coachingVC, dur: 0.5)  //writing
    }
    
    @objc private func handleCoachingEvaluationButton(){
        view.addSubview(coachingPreviewEvaluation.view)  //Change to evaluation
        refreshNavBar()
        coachingPreviewEvaluation.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }
    
    @objc private func handleCoachingFreshmanButton(){
        view.addSubview(coachingPreviewFreshman.view)  //Change to freshman
        refreshNavBar()
        coachingPreviewFreshman.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }
    
    @objc private func handleCoachingSophomoreButton(){
        view.addSubview(coachingPreviewSophomore.view)  //Change to sophomiore lol lololool
        refreshNavBar()
        coachingPreviewSophomore.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }

    @objc private func handleCoachingJuniorButton(){
        view.addSubview(coachingPreviewJunior.view)  //Change to freshman
        refreshNavBar()
        coachingPreviewJunior.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }

    @objc private func handleCoachingSeniorButton(){
        view.addSubview(coachingPreviewSenior.view)  //Change to freshman
        refreshNavBar()
        coachingPreviewSenior.pushDownVC(coachingVC, dur: 0.5)  //evaluation
    }

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if(sender.direction == .Left || sender.direction == .Right) {
            UIView.animateWithDuration(0.3, animations: {
                self.navItem.titleLabel.alpha = 0
            })
        }
    }
    override func handleStartMove() {
        UIView.animateWithDuration(0.5, animations: {
            self.navItem.titleLabel.alpha = 0
        })
    }
    override func handleEndMove(){
        UIView.animateWithDuration(0.5, animations: {
            self.navItem.titleLabel.alpha = 1
        })
    }
    override func handleEndMoveSamePage() {
        UIView.animateWithDuration(0.5, animations: {
            self.navItem.titleLabel.alpha = 1
        })
    }
    
    
    ////////////////////////////////////////////////
    //--------------The Hub Methods---------------//
    ////////////////////////////////////////////////
    
    internal func addCard(y: Int, size: Int, vc: UIScrollView){
        let card: HubCard = HubCard(vc: self,type: "Reminder",x: 20, y: y, width: Int(Constants.ScreenWidth-40),height: size)
        hubCards.append(card)
        vc.addSubview(card)
    }
    internal func deleteHubCard(card: HubCard){
        card.removeFromSuperview()
        hubCards.removeAtIndex(hubCards.indexOf(card)!)
        refreshHubCards()
    }
    

    
    /////////////////////////////////////////////////
    //--------------Coaching Methods---------------//
    /////////////////////////////////////////////////
    
    
    
    
    
    
    
    ///////////////////////////////////////////////
    //--------------Career Methods---------------//
    ///////////////////////////////////////////////

    
}

/////////////////////////////////////////////////
//----------------Extension--------------------//
/////////////////////////////////////////////////


extension MySwipeVC: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        
        let coachingColor = MaterialColor.white.CGColor
        let careerColor = MaterialColor.white.CGColor
        let hubColor = MaterialColor.purple.lighten3.CGColor

        
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
        gradientLayer.colors = [MaterialColor.blue.base.CGColor, MaterialColor.blue.lighten2.CGColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    func getGradient2() -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [MaterialColor.lightGreen.darken1.CGColor, MaterialColor.lightGreen.lighten1.CGColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    func getGradient3() -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [Constants.Color3.CGColor, Constants.Color4.CGColor]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    func indexOfStartingPage() -> Int {
        return 1
    }
    
    func changedToPageIndex(index: Int) {
        resfreshTitle(titlesForPages()[index])
        self.currentVC = stackPageVC[index]
    }
    
    func titlesForPages() -> [String] {
        return ["Coaching", "The Hub", "Career"]
    }
}
