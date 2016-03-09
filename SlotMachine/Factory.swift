//
//  Factory.swift
//  SlotMachine
//
//  Created by Neil Houselander on 24/02/2016.
//  Copyright © 2016 Neil Houselander. All rights reserved.
//

import Foundation
import UIKit


class Factory {
    
    //this function creates an array of cards 3 columns each holding 3 cards (the columns will not have duplicate cards thanks to the createSlot function below)
    class func createSlotsMainArray() -> [[Slot]] {
        let kNumberOfColumns = 3
        let kNumberOfSlotsPerColumn = 3
        var arrayOfSlotArrays: [[Slot]] = []
        
        //first loop creates columns
        for var containerColumnNumber = 0; containerColumnNumber < kNumberOfColumns; ++containerColumnNumber {
            var columnSlotArray: [Slot] = []
            
            //second for loop creates the slots that go in the column so this happens 3 times
            //and adds the makeSlot each time to the column slot array
            for var slotNumber = 0; slotNumber < kNumberOfSlotsPerColumn; ++slotNumber {
                let newSlot = Factory.createSlot(columnSlotArray)
                columnSlotArray.append(newSlot)
            }
            
            //once this loop has added 3 slots the column array gets added to the main array of arrays
            arrayOfSlotArrays.append(columnSlotArray)
        }
        return arrayOfSlotArrays
    }
    
    //this function creates a random card to go into the column array & tests to make sure the same value is not already there
    //it gets called in the createSlotsMainArray above
    
    class func createSlot (currentCards: [Slot]) -> Slot {

        //create a TEST array to hold slot values ready to use to comparte to the new value created
        var currentCardValues: [Int] = []
        
        //run for loop to extract the values from the currentCards array passed to it (the current column)
        //add the values to the TEST array we created to hold them
        
        for card in currentCards {
            currentCardValues.append(card.value)
        }
        
        //make a random number max 13
        var randomNumber = Int(arc4random_uniform(UInt32(13)))
        
        //test the random number doesn't match whats in the TEST array already
        //if it is do the random thing again
        while currentCardValues.contains(randomNumber + 1) {
            randomNumber = Int(arc4random_uniform(UInt32(13)))
        }
 
        //create a slot variable
        var theSlot: Slot
        
        //make a switch statement to generate a card based on the random number
        
        switch randomNumber {
        case 0:
            theSlot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
        case 1:
            theSlot = Slot(value: 2, image: UIImage(named: "Two"), isRed: true)
        case 2:
            theSlot = Slot(value: 3, image: UIImage(named: "Three"), isRed: true)
        case 3:
            theSlot = Slot(value: 4, image: UIImage(named: "Four"), isRed: true)
        case 4:
            theSlot = Slot(value: 5, image: UIImage(named: "Five"), isRed: false)
        case 5:
            theSlot = Slot(value: 6, image: UIImage(named: "Six"), isRed: false)
        case 6:
            theSlot = Slot(value: 7, image: UIImage(named: "Seven"), isRed: true)
        case 7:
            theSlot = Slot(value: 8, image: UIImage(named: "Eight"), isRed: false)
        case 8:
            theSlot = Slot(value: 9, image: UIImage(named: "Nine"), isRed: false)
        case 9:
            theSlot = Slot(value: 10, image: UIImage(named: "Ten"), isRed: true)
        case 10:
            theSlot = Slot(value: 11, image: UIImage(named: "Jack"), isRed: false)
        case 11:
            theSlot = Slot(value: 12, image: UIImage(named: "Queen"), isRed: false)
        case 12:
            theSlot = Slot(value: 13, image: UIImage(named: "King"), isRed: true)
        default:
            theSlot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
            
        }
        return theSlot
        
    }
}
