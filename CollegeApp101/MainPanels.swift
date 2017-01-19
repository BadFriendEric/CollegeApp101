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
            return 35
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
    var coachingVC: CoachingVC! = nil
    var careerVC: UIViewController! = nil
    var currentVC: UIViewController!
    var hubScrollView = HubVC()
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
    
    var navBarHighlightColor = Color.black
    let navColor = Color.grey.lighten2
    
    
    ///Navigation Bar Variables///
    let navBar: NavigationBar = NavigationBar(frame: CGRect(origin:CGPoint(x: 0,y: MainSwipeController.Constants.StatusBarHeight),size:CGSize(width: Constants.ScreenWidth,height: Constants.navBarHeight)))
    let navItem: UINavigationItem = UINavigationItem()
    let titleLabel = UILabel()
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
    fileprivate var hubCardBottom = Int(Constants.navBarHeight)+300
    fileprivate var hubCardSpacing = 20
    
    let profile : Profile = Profile(user: "samhollenbach", pass: "password")
    
    
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
        coachingVC.prepareView(main: self)
        hubScrollView.prepareView(main: self)
        print(hubCardBottom)
        let c = addCard(hubCardBottom, size: 160, vc: hubScrollView)
        c.type = "Default"
        refreshHubCards()
        
    }
    
    
    fileprivate func prepareView(){
        view.backgroundColor = Color.grey.lighten2
        
        
    }
    fileprivate func prepareHelpButton(){
        let helpButtonImage: UIImage? = UIImage(named: "HelpIcon")
        let s = Constants.navBarHeight - 10
        let imageSize = CGSize(width: s, height: s)
        _ = MainPanels.ResizeImage(helpButtonImage!, targetSize: imageSize)
        helpButton = UIImageView(image: helpButtonImage)
        helpButton.frame = CGRect(origin: CGPoint(x: navBar.width-45, y: 5), size: imageSize)
        helpButtonView.frame = CGRect(x: Int(navBar.width) - buttonWidths, y: 0, width: buttonWidths, height: Int(Constants.navBarHeight))
    }
    fileprivate func prepareMenuButton(){
        let menuButtonImage: UIImage? = UIImage(named: "MenuIcon")
        let s = Constants.navBarHeight - 15
        let imageSize = CGSize(width: s, height: s)
        _ = MainPanels.ResizeImage(menuButtonImage!, targetSize: imageSize)
        menuButton = UIImageView(image: menuButtonImage)
        menuButton.frame = CGRect(origin: CGPoint(x: 15, y: 5), size: imageSize)
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
        
        navBar.setItems([navItem], animated: false)
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: Int(navBar.frame.width), height: Int(Constants.navBarHeight))
        navBar.contentEdgeInsets = UIEdgeInsets.zero
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Oswald", size: 24)
        titleLabel.textColor = navBarHighlightColor
        
        navBar.addSubview(titleLabel)
        
        
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
        hubScrollView.frame = CGRect(x: 0, y: Constants.navBarHeight - 15, width: navBar.width, height: hubVC.view.frame.height-Constants.navBarHeight)
        
        
        hubVC.view.addSubview(hubScrollView)
        
        //self.addChildViewController(menu)
    }
    
    ///Prepare Career Panel///
    internal func prepareCareerView(){
        careerFeatureView.frame = CGRect(x: 0, y: Constants.navBarHeight+Constants.statusBarHeight, width: navBar.width, height: careerVC.view.frame.height-Constants.navBarHeight-Constants.statusBarHeight)
        let cf1: CareerFeature = CareerFeatureTopSchools()
        let cf2: CareerFeature = CareerFeatureResumeBuilder()
        let cf3: CareerFeature = CareerFeature()
        let cf4: CareerFeature = CareerFeatureVolunteerMatch()
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
        cf1.setColor(Color.blue.lighten2)
        cf2.setColor(Color.indigo.lighten2)
        cf3.setColor(Color.deepPurple.lighten2)
        cf4.setColor(Color.purple.lighten2)
        cf5.setColor(Color.pink.lighten2)
        cf3.setFeatureTitle("Reminders")
        //cf4.setFeatureTitle("Volunteer Match")
        cf5.setFeatureTitle("Essay Planner")
        
        careerVC.view.addSubview(careerFeatureView)
        
    }
    
    
    
    /////////////////////////////////////////////////
    //---------------Refresh Methods---------------//
    /////////////////////////////////////////////////
    
    
    internal func refreshTitle(_ title: String){
        titleLabel.text = title
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
        var currentCardPos = hubCardBottom + hubCardSpacing
        for card in hubCards{
            if(Int(card.y) > currentCardPos){
                UIView.animate(withDuration: 0.3, animations: {
                    card.y = CGFloat(currentCardPos)
                })
            }
            currentCardPos = Int(card.y) + Int(card.height) + hubCardSpacing
        }
        if(hubCards.isEmpty){
            hubCardBottom = hubCardBottom + hubCardSpacing
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
        titleLabel.removeFromSuperview()
        navBar.addSubview(titleLabel)
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
        let size = 160
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
        let hubColor = UIColor(red:0.09, green:0.63, blue:0.52, alpha:1.0).cgColor
        //let hubColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0).cgColor
        
        
        let coachingVC = CoachingVC()
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

extension UIImage {
    var rounded: UIImage? {
        let imageView = UIImageView(image: self)
        imageView.layer.cornerRadius = min(size.height/4, size.width/4)
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    var circle: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

