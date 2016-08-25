//
//  CareerFeaturePlanner.swift
//  CollegeApp101
//
//  Created by Sam Hollenbach on 8/10/16.
//  Copyright © 2016 CollegeApp101. All rights reserved.
//

import UIKit
import Foundation
import Material

public class CareerFeaturePlanner : CareerFeature, MaterialSwitchDelegate {
    
    
    enum PlannerSortType {
        case DateCreatedOldest
        case DateCreatedNewest
        case LastEdited
    }
    
    var sortType : PlannerSortType = .DateCreatedNewest
    
    
    let noteSwitch : MaterialSwitch! = MaterialSwitch(state: .On, style: .LightContent, size: .Default)
    let reminderSwitch : MaterialSwitch! = MaterialSwitch(state: .On, style: .LightContent, size: .Default)
    let listSwitch : MaterialSwitch! = MaterialSwitch(state: .On, style: .LightContent, size: .Default)
    
    var showNotes = true
    var showReminders = true
    var showLists = true
    
    var items : [PlannerItem]! = [PlannerItem]()
    var itemsMinY = 160
    
    
    public override init() {
        super.init()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func setFrame(x: Int, y: Int, width: Int, height: Int) {
        super.setFrame(x, y: y, width: width, height: height)
        setFeatureTitle("Top Schools")
        prepareMainButtons()
        prepareMainLabels()
        prepareMainSwitches()
        prepareFeatures()
        refreshScrollView(height+400)
    }
    
    private func prepareMainButtons(){
        let w: CGFloat = 50
        let imgNote: UIImage? = MaterialIcon.cm.pen
        let createNote: FabButton = FabButton(frame: CGRectMake(view.bounds.width/2 - 2.5*w, 5, w, w))
        createNote.setImage(imgNote, forState: .Normal)
        createNote.setImage(imgNote, forState: .Highlighted)
        
        let imgReminder: UIImage? = MaterialIcon.cm.bell
        let createReminder: FabButton = FabButton(frame: CGRectMake((view.bounds.width - w)/2, 5, w, w))
        createReminder.setImage(imgReminder, forState: .Normal)
        createReminder.setImage(imgReminder, forState: .Highlighted)
        
        
        let imgList: UIImage? = MaterialIcon.cm.moreVertical
        let createList: FabButton = FabButton(frame: CGRectMake(view.bounds.width/2 + 1.5*w, 5, w, w))
        createList.setImage(imgList, forState: .Normal)
        createList.setImage(imgList, forState: .Highlighted)
        
        features.append(createNote)
        features.append(createReminder)
        features.append(createList)
    }
    
    private func prepareMainLabels(){
        let w: CGFloat = 50
        let noteLabel = UILabel(frame: CGRect(x: view.bounds.width/2 - 2.5*w, y: 5+w, width: w+10, height: 20))
        noteLabel.text = "Notes"
        noteLabel.numberOfLines = 1
        noteLabel.font = RobotoFont.thinWithSize(20)
        noteLabel.textColor = MaterialColor.white
        
        let reminderLabel = UILabel(frame: CGRect(x: (view.bounds.width - w)/2-20, y: 5+w, width: w+45, height: 20))
        reminderLabel.text = "Reminders"
        reminderLabel.numberOfLines = 1
        reminderLabel.font = RobotoFont.thinWithSize(20)
        reminderLabel.textColor = MaterialColor.white
        
        let listLabel = UILabel(frame: CGRect(x: view.bounds.width/2 + 1.5*w+5, y: 5+w, width: w+10, height: 20))
        listLabel.text = "Lists"
        listLabel.numberOfLines = 1
        listLabel.font = RobotoFont.thinWithSize(20)
        listLabel.textColor = MaterialColor.white
        
        features.append(noteLabel)
        features.append(reminderLabel)
        features.append(listLabel)
    }
    
    private func prepareMainSwitches(){
        let w: CGFloat = 50
        let buttonOnColor = MaterialColor.lightGreen.base
        let trackOnColor = MaterialColor.white
        noteSwitch.trackOnColor = trackOnColor
        noteSwitch.buttonOnColor = buttonOnColor
        noteSwitch.delegate = self
        noteSwitch.x = view.bounds.width/2 - 2.5*w+5
        noteSwitch.y = 35+w
        
        reminderSwitch.trackOnColor = trackOnColor
        reminderSwitch.buttonOnColor = buttonOnColor
        reminderSwitch.delegate = self
        reminderSwitch.x = (view.bounds.width - w)/2+5
        reminderSwitch.y = 35+w
        
        listSwitch.trackOnColor = trackOnColor
        listSwitch.buttonOnColor = buttonOnColor
        listSwitch.delegate = self
        listSwitch.x = view.bounds.width/2 + 1.5*w+5
        listSwitch.y = 35+w
        
        features.append(noteSwitch)
        features.append(reminderSwitch)
        features.append(listSwitch)
        
        
        
    }
    
    public override func updateFrame(){
        super.updateFrame()
    }
    
    public override func getFeatures() -> [UIView] {
        return features
    }
    
    
    public func updatePlanner(){
        let note : PlannerItem = PlannerItem(cfp: self, y: self.itemsMinY)
        note.type = PlannerItem.PlannerItemType.Note
        items.append(note)
        
        let note2 : PlannerItem = PlannerItem(cfp: self, y: self.itemsMinY+90)
        note2.type = PlannerItem.PlannerItemType.Note
        items.append(note2)
        
        if(items.isEmpty){
            return()
        }
        
        //var sortedItems : [PlannerItem] = [PlannerItem]()
        
        
        switch sortType {
        case .DateCreatedNewest :
            print("Sort by Date Created Newest")
        default:
            print("Default Sort")
        }
        
        
        for i in 0..<items.count {
            items[i].removeFromSuperview()
            scrollView.addSubview(items[i])
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    public func materialSwitchStateChanged(control: MaterialSwitch) {
        if(control == noteSwitch){
            showNotes = control.on
        }else if(control == reminderSwitch){
            showReminders = control.on
        }else if(control == listSwitch){
            showLists = control.on
        }
        updatePlanner()
    }
    
    
    
    
    
    
    
}