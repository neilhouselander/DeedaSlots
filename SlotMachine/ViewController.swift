//
//  ViewController.swift
//  SlotMachine
//
//  Created by Neil Houselander on 15/02/2016.
//  Copyright © 2016 Neil Houselander. All rights reserved.
//

//NEIL NEXT -
//THE IMPLEMENT FOR ROW TWO & THREE winner labels

import UIKit

class ViewController: UIViewController {
    
    //MARK: class properties & Constants
    //set up the 4 views
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    //array to hold the generated cards (in BitFountain this variable was called slots)
    var theCards: [[Slot]] = []
    
    
    //MARK: Constants
    //constants - Fractions
    let kMarginForView: CGFloat = 10.0
    let kSixth :CGFloat = 1.0/6.0
    let kTopHeaderMargin: CGFloat = 18.0
    let kThird : CGFloat = 1.0/3.0
    let kHalf: CGFloat = 1.0/2.0
    let kEighth: CGFloat = 1.0/8.0
    let kMarginForSlot : CGFloat = 10.0
    
    //constants - containers
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    
    
    //font constants
    let kLabelFont = "Menlo-Bold"
    let kTitleLabelFont = "MarkerFelt-Wide"
    let kButtonFont = "Superclarendon-Bold"
    
    //game Constants
    let kMaxBet = 5
    
   
    //colour constants
    let kBackgroundHeaderAndFooter = UIColor(red: 114/255  , green: 161/255, blue: 171/255, alpha: 1.0)
    let kBackgroundToStatsLabels = UIColor(red: 114/255, green: 161/255, blue: 171/255, alpha: 1)
    let kbackgroundCardSection = UIColor(red: 200/255, green: 171/255, blue: 116/255, alpha: 1)
    let kFontColor = UIColor.yellowColor()
    
    //MARK: Labels & Buttons Declarations
    //information Labels - Container 1 & 3
    var titleLabel: UILabel!
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    //neils winner labels
    
    var rowOneWinner: UILabel!
    var rowTwoWinner: UILabel!
    var rowThreeWinner: UILabel!
    
    //button labels
    var resetButtonLabel: UILabel!
    var betOneButtonLabel: UILabel!
    var betMaxButtonLabel:UILabel!
    var spinButtonLabel: UILabel!
    
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
        self.winnings = 0
        self.updateMainView()
        
        if self.credits <= 0 {
            self.showAlertWithText("No more credits", message: "Reset Game")
        }
        else {
            if self.currentBet < self.kMaxBet {
                self.currentBet += 1
                self.credits -= 1
                self.updateMainView()
            }
            else {
                self.showAlertWithText(message: "You can only bet 5 credits at a time")
            }
        }
    }
    
    func betMaxButtonPressed (button: UIButton) {
        print("bet max button pressed")
        self.winnings = 0
        self.updateMainView()
        
        if self.credits == 0 {
            showAlertWithText("No More Credits", message: "Reset Game")
            
        }
        else if self.credits < self.kMaxBet {
            showAlertWithText("Not enough credits", message: "Bet Less")
        }
              
        else {
            if self.currentBet < self.kMaxBet {
                let creditsToBetMax = self.kMaxBet - self.currentBet
                self.credits -= creditsToBetMax
                self.currentBet += creditsToBetMax
                self.updateMainView()
            }
            else {
                self.showAlertWithText(message: "You can only bet 5 credits max")
            }
        }
        
        
    }
    
    func spinButtonPressed (button: UIButton) {
        if currentBet == 0 {
            self.showAlertWithText(message: "Please place a bet")
        }
        else {
            self.removeSlotImageViews()
            
            self.rowOneWinner.hidden = true
            self.rowTwoWinner.hidden = true
            self.rowThreeWinner.hidden = true
            
            self.theCards = Factory.createSlotsMainArray()
            self.setUpSecondContainer(self.secondContainer)
            let winningsMultiplier = SlotBrain.computeWinnings(theCards)
            winnings = winningsMultiplier * currentBet
            print ("current bet: \(currentBet) * winnings multiplier: \(winningsMultiplier) = winnings: \(winnings)" )
            credits += winnings
            currentBet = 0
            updateMainView()
            
            // winner label updates
            let rowOneWinner = SlotBrain.isRowOneAWinner(theCards)
            let rowTwoWinner = SlotBrain.isRowTwoAWinner(theCards)
            let rowThreeWinner = SlotBrain.isRowThreeAWinner(theCards)
            
            
            if rowOneWinner == true {
                print("Row One Winner")
                self.rowOneWinner.hidden = false
            }
            if rowTwoWinner == true {
                print("Row Two Winner")
                self.rowTwoWinner.hidden = false
            }
            if rowThreeWinner == true {
                print("Row Three Winner")
                self.rowThreeWinner.hidden = false
            }
            
        }
      }
    
    
    
    //MARK: Main Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundHeaderAndFooter
        
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
    
    
    //MARK: Set up container functions
    
    //set up the four containers to hold the action
    func setUpContainerViews () {
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x  ,
                                                   y: self.view.bounds.origin.y ,
                                                   width: self.view.bounds.width ,
                                                   height: self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = kBackgroundHeaderAndFooter
        self.view.addSubview(self.firstContainer)
        
        //x & y are where to show IN THE VIEW BEING ADDED TO - so if you add to self.view then relative to whole view BUT if you add to say second container x & y is relative to that container
    
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x,
                                                    y: self.firstContainer.frame.height,
                                                    width: self.view.bounds.width ,
                                                    height: self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = kbackgroundCardSection
        self.view.addSubview(self.secondContainer)
        
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x ,
                                                   y: self.firstContainer.frame.height + self.secondContainer.frame.height + 1.0,
                                                   width: self.view.bounds.width ,
                                                   height: self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = kbackgroundCardSection
        self.view.addSubview(self.thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x ,
                                                    y: self.firstContainer.frame.height + self.secondContainer.frame.height + self.thirdContainer.frame.height,
                                                    width: self.view.bounds.width ,
                                                    height: self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = kBackgroundHeaderAndFooter
        self.view.addSubview(self.fourthContainer)
    }


    
    //first container - title
    func setUpFirstContainer (containerView: UIView) {
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Deeda Slots"
        self.titleLabel.textColor = kFontColor
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = CGPointMake(containerView.center.x , containerView.center.y )
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
                    slotImageView.image = UIImage(named: "redBackFinal")
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                
                //each card box dimensions so go into CGRect below
                let containerWidth = (containerView.bounds.size.width / CGFloat(kNumberOfContainers) - (kMarginForSlot)) - 20 //to make the cards more rectabgular
                let containerHeight = containerView.bounds.size.height/CGFloat(kNumberOfSlots) - (kMarginForSlot)
                
                //make the squares
                slotImageView.frame = CGRect(
                    x: containerView.bounds.origin.x + kMarginForSlot + 10 + ((containerView.bounds.size.width - kMarginForSlot) * CGFloat(containerNumber) / CGFloat(kNumberOfContainers)),
                    y: containerView.bounds.origin.y + kMarginForSlot + ((containerView.bounds.size.height - kMarginForSlot) * CGFloat (slotNumber) / CGFloat(kNumberOfSlots)),
                    width: containerWidth,
                    height: containerHeight)
                
                containerView.addSubview(slotImageView)
            }
        }
        self.rowOneWinner = UILabel()
        self.rowOneWinner.text = "WINNER        "
        self.rowOneWinner.textColor = kFontColor
        self.rowOneWinner.font = UIFont(name: kLabelFont, size: 40)
        self.rowOneWinner.sizeToFit()
        self.rowOneWinner.center = CGPoint(x: containerView.bounds.size.width * kHalf, y: containerView.bounds.size.height * kSixth)
        self.rowOneWinner.textAlignment = NSTextAlignment.Center
        self.rowOneWinner.backgroundColor = UIColor(red: 114/255  , green: 161/255, blue: 171/255, alpha: 0.6)
        self.rowOneWinner.hidden = true
        containerView.addSubview(self.rowOneWinner)
        
        self.rowTwoWinner = UILabel()
        self.rowTwoWinner.text = "WINNER        "
        self.rowTwoWinner.textColor = kFontColor
        self.rowTwoWinner.font = UIFont(name: kLabelFont, size: 40)
        self.rowTwoWinner.sizeToFit()
        self.rowTwoWinner.center = CGPoint(x: containerView.bounds.size.width * kHalf, y: containerView.bounds.size.height * (kSixth * 3))
        self.rowTwoWinner.textAlignment = NSTextAlignment.Center
        self.rowTwoWinner.backgroundColor = UIColor(red: 114/255  , green: 161/255, blue: 171/255, alpha: 0.6)
        self.rowTwoWinner.hidden = true
        containerView.addSubview(self.rowTwoWinner)
        
        self.rowThreeWinner = UILabel()
        self.rowThreeWinner.text = "WINNER        "
        self.rowThreeWinner.textColor = kFontColor
        self.rowThreeWinner.font = UIFont(name: kLabelFont, size: 40)
        self.rowThreeWinner.sizeToFit()
        self.rowThreeWinner.center = CGPoint(x: containerView.bounds.size.width * kHalf, y: containerView.bounds.size.height * (kSixth * 5))
        self.rowThreeWinner.textAlignment = NSTextAlignment.Center
        self.rowThreeWinner.backgroundColor = UIColor(red: 114/255  , green: 161/255, blue: 171/255, alpha: 0.6)
        self.rowThreeWinner.hidden = true
        containerView.addSubview(self.rowThreeWinner)
    }

    //third container - the information labels
    func setUpThirdContainer (containerView: UIView) {
        
        
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = kFontColor
        self.creditsLabel.font = UIFont(name: kLabelFont, size: 20)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: containerView.bounds.size.width * kSixth, y: containerView.bounds.size.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = kBackgroundHeaderAndFooter
        containerView.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = kFontColor
        self.betLabel.font = UIFont(name: kLabelFont, size: 20)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: containerView.bounds.width * (kSixth * 3), y: containerView.bounds.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = kBackgroundHeaderAndFooter
        containerView.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = kFontColor
        self.winnerPaidLabel.font = UIFont(name: kLabelFont, size: 20)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: containerView.bounds.width * (kSixth * 5), y: containerView.bounds.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = kBackgroundHeaderAndFooter
        containerView.addSubview(self.winnerPaidLabel)
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = kFontColor
        self.creditsTitleLabel.font = UIFont(name: kTitleLabelFont, size: 16)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.bounds.width * kSixth, y: containerView.bounds.height * (kThird * 2))
        self.creditsTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.creditsTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = kFontColor
        self.betTitleLabel.font = UIFont(name: kTitleLabelFont, size: 16)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.bounds.width * (kSixth * 3), y: containerView.bounds.height * (kThird * 2))
        self.betTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.betTitleLabel)
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.textColor = kFontColor
        self.winnerPaidTitleLabel.font = UIFont(name: kTitleLabelFont, size: 16)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.bounds.width * (kSixth * 5), y: containerView.bounds.height * (kThird * 2))
        self.winnerPaidTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.winnerPaidTitleLabel)
    }
    
    //fourth Container - buttons
    
    func setUpFourthContainer (containerView: UIView) {
        
        //this was a function to generate buttons with titles, I dropped it in favour of graphical buttons
        
//        func setUpButtons (buttonName: UIButton, buttonTitle: String, titleColour: UIColor, backgroundColour: UIColor, position: Int, buttonCall: Selector) {
//            
//            buttonName.setTitle(buttonTitle, forState: UIControlState.Normal)
//            buttonName.setTitleColor(titleColour, forState: UIControlState.Normal)
//            buttonName.titleLabel?.font = UIFont(name: kButtonFont, size: 12)
//            buttonName.backgroundColor = backgroundColour
//            buttonName.sizeToFit()
//            buttonName.center = CGPoint(x: containerView.bounds.width * (kEighth * CGFloat(position * 2 + 1)), y: containerView.bounds.height * kHalf)
//            buttonName.addTarget(self, action: buttonCall, forControlEvents: UIControlEvents.TouchUpInside)
//            containerView.addSubview(buttonName)
//            
//        }
//        
//        self.resetButton = UIButton()
//        self.betOneButton = UIButton()
//        self.betMaxButton = UIButton()
//        self.spinButton = UIButton()
//        
//        setUpButtons(resetButton, buttonTitle: "Reset", titleColour: UIColor.blueColor(), backgroundColour: UIColor.lightGrayColor(), position: 0, buttonCall: "resetButtonPressed:")
//        setUpButtons(betOneButton, buttonTitle: "Bet One", titleColour: UIColor.blueColor(), backgroundColour: UIColor.greenColor(), position: 1, buttonCall: "betOneButtonPressed:")
//        setUpButtons(betMaxButton, buttonTitle: "Bet Max", titleColour: UIColor.blueColor(), backgroundColour: UIColor.redColor(), position: 2, buttonCall: "betMaxButtonPressed:")
//        setUpButtons(spinButton, buttonTitle: "Spin", titleColour: UIColor.blueColor(), backgroundColour: UIColor.greenColor(), position: 3, buttonCall: "spinButtonPressed:")
        
        
        //set up graphical buttons
        func newSetUpGraphicButtons (buttonName: UIButton, backGroundImage: String,highlightedBackGroundImage: String, position: Int, buttonCall: Selector) {
            
            buttonName.setBackgroundImage(UIImage(named: backGroundImage), forState: UIControlState.Normal)
            buttonName.setBackgroundImage(UIImage(named: backGroundImage), forState: UIControlState.Highlighted)
            buttonName.bounds.size = CGSize(width: 50.0, height: 63.0)
            //buttonName.sizeToFit()
            buttonName.center = CGPoint(x: containerView.bounds.width * (kEighth * CGFloat(position * 2 + 1)), y: containerView.bounds.height * kThird)
            buttonName.addTarget(self, action: buttonCall, forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(buttonName)
        }
        
        self.resetButton = UIButton()
        self.betOneButton = UIButton()
        self.betMaxButton = UIButton()
        self.spinButton = UIButton()
        
        newSetUpGraphicButtons(
            resetButton,
            backGroundImage: "resetGraphic",
            highlightedBackGroundImage: "resetHighlighted",
            position: 0,
            buttonCall: "resetButtonPressed:")
        newSetUpGraphicButtons(betOneButton, backGroundImage: "betOneGraphic",highlightedBackGroundImage: "betOneGraphicHighlighted", position: 1, buttonCall: "betOneButtonPressed:")
        newSetUpGraphicButtons(betMaxButton, backGroundImage: "betMaxGraphic",highlightedBackGroundImage: "betMaxHighlighted", position: 2, buttonCall: "betMaxButtonPressed:")
        newSetUpGraphicButtons(spinButton, backGroundImage: "spinGraphic",highlightedBackGroundImage: "spinGraphicHighligted", position: 3, buttonCall: "spinButtonPressed:")
        
        //set up the labels to go under those buttons
        func buttonLabelSetUp (labelName: UILabel, labelText: String, position: Int, belowButtonCalled: UIButton) {
            labelName.text = labelText
            labelName.textColor = UIColor.yellowColor()
            labelName.font = UIFont(name: kTitleLabelFont, size: 12)
            labelName.sizeToFit()
            labelName.center = CGPoint(x: belowButtonCalled.frame.origin.x + (belowButtonCalled.frame.width * kHalf), y: belowButtonCalled.frame.height + 25.0 )
            labelName.textAlignment = NSTextAlignment.Center
            containerView.addSubview(labelName)
        }
        
        self.resetButtonLabel = UILabel()
        self.betOneButtonLabel = UILabel()
        self.betMaxButtonLabel = UILabel()
        self.spinButtonLabel = UILabel()
        
        buttonLabelSetUp(resetButtonLabel, labelText: "Reset", position: 0, belowButtonCalled: resetButton)
        buttonLabelSetUp(betOneButtonLabel, labelText: "Bet One", position: 1, belowButtonCalled: betOneButton)
        buttonLabelSetUp(betMaxButtonLabel, labelText: "Bet Max", position: 2, belowButtonCalled: betMaxButton)
        buttonLabelSetUp(spinButtonLabel, labelText: "Deal", position: 3, belowButtonCalled: spinButton)
        
    }
    
    //MARK: helper functions
    
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
        self.setUptheHighlightImages()
    }
    
    func updateMainView () {
        self.creditsLabel.text = "\(self.credits)"
        self.betLabel.text = "\(self.currentBet)"
        self.winnerPaidLabel.text = "\(self.winnings)"
        
    }
    
    func showAlertWithText (header: String = "Warning", message: String) {
        let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func setUptheHighlightImages () {
        self.betOneButton.setBackgroundImage(UIImage(named: "betOneGraphicHighlighted"), forState: UIControlState.Highlighted)
        self.betMaxButton.setBackgroundImage(UIImage(named: "betMaxHighlighted"), forState: UIControlState.Highlighted)
        self.spinButton.setBackgroundImage(UIImage(named: "spinGraphicHighligted"), forState: UIControlState.Highlighted)
        self.resetButton.setBackgroundImage(UIImage(named: "resetHighlighted"), forState: UIControlState.Highlighted)
    }
    
}

