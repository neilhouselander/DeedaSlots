//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Neil Houselander on 03/03/2016.
//  Copyright © 2016 Neil Houselander. All rights reserved.
//

import Foundation

class SlotBrain {
    
    class func unpackSlotIntoSlotRows (slotColumns: [[Slot]]) -> [[Slot]] {
        
        var slotRow1: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        for slotArray in slotColumns { //pull out all the arrays
            
            for var slotNumber = 0; slotNumber < slotArray.count; slotNumber++ {
                
                let slot = slotArray[slotNumber]
                
                switch slotNumber {
                    
                case 0:
                    slotRow1.append(slot)
     
                case 1:
                    slotRow2.append(slot)
                    
                case 2:
                    slotRow3.append(slot)
                    
                default:
                    print("Error")
                }
             }
          }
        let slotsInRows:[[Slot]] = [slotRow1, slotRow2, slotRow3]
        
        return slotsInRows
    }
    
    class func computeWinnings (slots: [[Slot]]) -> Int {
        
        let slotsInRowsArray = unpackSlotIntoSlotRows(slots)
        var winnings = 0
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        
        for slotRow in slotsInRowsArray {
            
            if checkFlush(slotRow) == true {
                winnings += 1
                print("Flush + 1 - winnings = \(winnings)")
                flushWinCount += 1
            }
            
            if checkForStraight(slotRow) == true {
                winnings += 1
                print("Staight + 1 - winnings multiplier = \(winnings)")
                straightWinCount += 1
            }
            
            if checkForThreeOfAKind(slotRow) == true {
                winnings += 3
                print("Three of a kind + 3 winnings multiplier = \(winnings)")
                threeOfAKindWinCount += 1
            }
            
        }
        
        if flushWinCount == 0 && straightWinCount == 0 && threeOfAKindWinCount == 0 {
            print("No Win")
        }
        
        if flushWinCount == 3 {
            print("Royal Flush + 15")
            winnings += 15
            print("Total multiplier: \(winnings)")
        }
        
        if straightWinCount == 3 {
            print("Epic Straight+ 1000")
            winnings += 1000
            print("Total multiplier: \(winnings)")
        }
        
        if threeOfAKindWinCount == 3 {
            print("All the threes + 50")
            winnings += 50
            print("Total multiplier: \(winnings)")
        }
        
        
        return winnings
        
    }
    
    class func checkFlush (slotRow: [Slot]) -> Bool {
        
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.isRed == true && slot2.isRed == true && slot3.isRed == true {
            return true
        }
        else if slot1.isRed == false && slot2.isRed == false && slot3.isRed == false {
            return true
        }
        else {
            return false
        }
 
    }
    
    class func checkForStraight (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 {
            return true
        }
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 {
            return true
        }
        else {
            return false
        }
    }
  
    
    class func checkForThreeOfAKind (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value && slot1.value == slot3.value {
            return true
        }
        else {
            return false
        }
    }
    
    
    class func isRowOneAWinner (slots: [[Slot]]) -> Bool {
        
        let newSlotsInRowsArray = unpackSlotIntoSlotRows(slots)
        let rowOne = newSlotsInRowsArray[0]
        
        if checkFlush(rowOne) == true || checkForStraight(rowOne) == true || checkForThreeOfAKind(rowOne) == true {
            return true
        }
        else {
            return false
            
        }
 
    }
    
    class func isRowTwoAWinner (slots: [[Slot]]) -> Bool {
        let newSlotsInRowsArray = unpackSlotIntoSlotRows(slots)
        let rowTwo = newSlotsInRowsArray[1]
        
        if checkFlush(rowTwo) == true || checkForStraight(rowTwo) == true || checkForThreeOfAKind(rowTwo) == true {
            return true
        }
        else {
            return false
        }
        
    }
    
    class func isRowThreeAWinner (slots: [[Slot]]) -> Bool {
        let newSlotsInArray = unpackSlotIntoSlotRows(slots)
        let rowThree = newSlotsInArray[2]
        
        if checkFlush(rowThree) == true || checkForStraight(rowThree) == true || checkForThreeOfAKind(rowThree) == true {
            return true
        }
        else {
            return false
        }
    }
    
    
    
    
}