//
//  ViewController.swift
//  SlotMachine
//
//  Created by Neil Houselander on 15/02/2016.
//  Copyright © 2016 Neil Houselander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: class properties & Constants
    //set up the 4 views
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    //array to hold the generated cards (in BitFountain this variable was called slots
    var theCards: [[Slot]] = []
    
    
    //constants - Fractions
    let kMarginForView: CGFloat = 10.0
    let kSixth :CGFloat = 1.0/6.0
    let kTopHeaderMargin: CGFloat = 18.0
    let kThird : CGFloat = 1.0/3.0
    let kHalf: CGFloat = 1.0/2.0
    let kEighth: CGFloat = 1.0/8.0
    let kMarginForSlot : CGFloat = 3.0
    
    //constants - containers
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    
    
    //font constants
    let kLabelFont = "Menlo-Bold"
    let kTitleLabelFont = "AmericanTypewriter"
    let kButtonFont = "Superclarendon-Bold"
    
    //MARK: Labels & Buttons Declarations
    //information Labels - Container 1 & 3
    var titleLabel: UILabel!
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    //buttons
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton : UIButton!
    
    //stats
    
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    //MARK: IBActions
    
    func resetButtonPressed (button: UIButton) {
        self.hardReset()
    }
    
    func betOneButtonPressed (button: UIButton) {
        print("bet one button pressed")
    }
    
    func betMaxButtonPressed (button: UIButton) {
        print("bet max button pressed")
    }
    
    func spinButtonPressed (button: UIButton) {
        self.removeSlotImageViews()
        self.theCards = Factory.createSlotsMainArray()
        self.setUpSecondContainer(self.secondContainer)

    }
    
    
    
    //MARK: Main Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpContainerViews()
        self.setUpFirstContainer(firstContainer)
        self.setUpThirdContainer(thirdContainer)
        self.setUpFourthContainer(fourthContainer)
        self.hardReset()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Helper functions
    
    //set up the four containers to hold the action
    func setUpContainerViews () {
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView ,
                                                   y: self.view.bounds.origin.y + kTopHeaderMargin,
                                                   width: self.view.bounds.width - (kMarginForView * 2),
                                                   height: self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        //x & y are where to show IN THE VIEW BEING ADDED TO - so if you add to self.view then relative to whole view BUT if you add to say second container x & y is relative to that container
    
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView,
                                                    y: self.firstContainer.frame.height,
                                                    width: self.view.bounds.width - (kMarginForView * 2),
                                                    height: self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView,
                                                   y: self.firstContainer.frame.height + self.secondContainer.frame.height,
                                                   width: self.view.bounds.width - (kMarginForView * 2),
                                                   height: self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView,
                                                    y: self.firstContainer.frame.height + self.secondContainer.frame.height + self.thirdContainer.frame.height,
                                                    width: self.view.bounds.width - (kMarginForView * 2),
                                                    height: self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
    }
    
    //first container - title
    func setUpFirstContainer (containerView: UIView) {
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Deeda Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = CGPointMake(containerView.center.x - kMarginForView, containerView.center.y - kTopHeaderMargin)
        containerView.addSubview(self.titleLabel)
    }
    
    //second container - the grid - where the cards live
    func setUpSecondContainer (containerView: UIView) {
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                
                var slot: Slot
                let slotImageView = UIImageView()
                
                //does the master card array hold anything? If no goto else, otherwise for each uiimage add the relevant picture
                if theCards.count != 0 {
                    let slotContainer = theCards[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }
                else {
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                
                //make the squares
                slotImageView.frame = CGRect(
                    x: containerView.bounds.origin.x + kMarginForSlot + ((containerView.bounds.size.width - kMarginForSlot) * CGFloat(containerNumber) / CGFloat(kNumberOfContainers)),
                    y: containerView.bounds.origin.y + kMarginForSlot + ((containerView.bounds.size.height - kMarginForSlot) * CGFloat (slotNumber) / CGFloat(kNumberOfSlots)),
                    width: containerView.bounds.size.width/CGFloat(kNumberOfContainers) - kMarginForSlot,
                    height: containerView.bounds.size.height/CGFloat(kNumberOfSlots) - kMarginForSlot)
                
                containerView.addSubview(slotImageView)
            }
        }
    }

    //third container - the information labels
    func setUpThirdContainer (containerView: UIView) {
        
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: kLabelFont, size: 16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: containerView.bounds.size.width * kSixth, y: containerView.bounds.size.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: kLabelFont, size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: containerView.bounds.width * (kSixth * 3), y: containerView.bounds.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: kLabelFont, size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: containerView.bounds.width * (kSixth * 5), y: containerView.bounds.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidLabel)
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: kTitleLabelFont, size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.bounds.width * kSixth, y: containerView.bounds.height * (kThird * 2))
        self.creditsTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.creditsTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: kTitleLabelFont, size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.bounds.width * (kSixth * 3), y: containerView.bounds.height * (kThird * 2))
        self.betTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.betTitleLabel)
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: kTitleLabelFont, size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.bounds.width * (kSixth * 5), y: containerView.bounds.height * (kThird * 2))
        self.winnerPaidTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.winnerPaidTitleLabel)
    }
    
    //fourth Container - buttons
    
    func setUpFourthContainer (containerView: UIView) {
        
        func setUpButtons (buttonName: UIButton, buttonTitle: String, titleColour: UIColor, backgroundColour: UIColor, position: Int, buttonCall: Selector) {
            buttonName.setTitle(buttonTitle, forState: UIControlState.Normal)
            buttonName.setTitleColor(titleColour, forState: UIControlState.Normal)
            buttonName.titleLabel?.font = UIFont(name: kButtonFont, size: 12)
            buttonName.backgroundColor = backgroundColour
            buttonName.sizeToFit()
            buttonName.center = CGPoint(x: containerView.bounds.width * (kEighth * CGFloat(position * 2 + 1)), y: containerView.bounds.height * kHalf)
            buttonName.addTarget(self, action: buttonCall, forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(buttonName)
            
        }
        
        self.resetButton = UIButton()
        self.betOneButton = UIButton()
        self.betMaxButton = UIButton()
        self.spinButton = UIButton()
        
        setUpButtons(resetButton, buttonTitle: "Reset", titleColour: UIColor.blueColor(), backgroundColour: UIColor.lightGrayColor(), position: 0, buttonCall: "resetButtonPressed:")
        setUpButtons(betOneButton, buttonTitle: "Bet One", titleColour: UIColor.blueColor(), backgroundColour: UIColor.greenColor(), position: 1, buttonCall: "betOneButtonPressed:")
        setUpButtons(betMaxButton, buttonTitle: "Bet Max", titleColour: UIColor.blueColor(), backgroundColour: UIColor.redColor(), position: 2, buttonCall: "betMaxButtonPressed:")
        setUpButtons(spinButton, buttonTitle: "Spin", titleColour: UIColor.blueColor(), backgroundColour: UIColor.greenColor(), position: 3, buttonCall: "spinButtonPressed:")
        
        
//        self.resetButton = UIButton()
//        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
//        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        self.resetButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
//        self.resetButton.titleLabel?.font = UIFont(name: kButtonFont, size: 12)
//        self.resetButton.backgroundColor = UIColor.lightGrayColor()
//        self.resetButton.sizeToFit()
//        self.resetButton.center = CGPoint(x: containerView.bounds.width * kEighth, y: containerView.bounds.height * kHalf)
//        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        containerView.addSubview(self.resetButton)
//        
//        
//        self.betOneButton = UIButton()
//        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
//        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        self.betOneButton.titleLabel?.font = UIFont(name: kButtonFont, size: 12)
//        self.betOneButton.backgroundColor = UIColor.greenColor()
//        self.betOneButton.sizeToFit()
//        self.betOneButton.center = CGPoint(x: containerView.bounds.width * (kEighth * 3) , y: containerView.bounds.height * kHalf)
//        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        containerView.addSubview(self.betOneButton)
//        
//        self.betMaxButton = UIButton()
//        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
//        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        self.betMaxButton.titleLabel?.font = UIFont(name: kButtonFont, size: 12)
//        self.betMaxButton.backgroundColor = UIColor.redColor()
//        self.betMaxButton.sizeToFit()
//        self.betMaxButton.center = CGPoint(x: containerView.bounds.width * (kEighth * 5), y: containerView.bounds.height * kHalf)
//        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        containerView.addSubview(self.betMaxButton)
//        
//        self.spinButton = UIButton()
//        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
//        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        self.spinButton.titleLabel?.font = UIFont(name: kButtonFont, size: 12)
//        self.spinButton.backgroundColor = UIColor.greenColor()
//        spinButton.sizeToFit()
//        self.spinButton.center = CGPoint(x: containerView.bounds.width * (kEighth * 7), y: containerView.bounds.height * kHalf)
//        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        containerView.addSubview(self.spinButton)
         
    }
    
    //more helpers
    
    func removeSlotImageViews () {
        if self.secondContainer != nil {
            let container: UIView? = self.secondContainer
            let subViews: Array? = container!.subviews
            for view in subViews! {
                view.removeFromSuperview()
            }
            
        }
        
    }
    
    func hardReset () {
        self.removeSlotImageViews()
        self.theCards.removeAll(keepCapacity: true)
        self.setUpSecondContainer(secondContainer)
        self.credits = 50
        self.winnings = 0
        self.currentBet = 0
        self.updateMainView()
    }
    
    func updateMainView () {
        self.creditsLabel.text = "\(self.credits)"
        self.betLabel.text = "\(self.currentBet)"
        self.winnerPaidLabel.text = "\(self.winnings)"
        
    }
    
    
    
    
}

