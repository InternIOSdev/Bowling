//
//  Round.swift
//  Bowling
//
//  Created by Egor Salnikov on 18.02.2021.
//

import Foundation

struct Round {
    
    private(set) var rolls: [Int] = []
    
    var isSpare: Bool {
        return rolls.count == 2 && brokenPins == maxPinCount
    }
    
    var isStrike: Bool {
        return rolls.count == 1 && rolls.first == maxPinCount
    }
    
    var isLastRound: Bool {
        return history.count == numberOfRounds - 1
    }
    
    var brokenPins: Int {
        return rolls.reduce(0, +)
    }
    
    var remainingPins: Int {
        return maxPinCount - brokenPins
    }
    
    var isFinished: Bool {
        
        if isExtendedRound {
            return rolls.count == 3
        } else {
            return rolls.count == 2 || isStrike
        }
    }
  
    mutating func considerRoll(_ downedPins: Int) -> Bool {
        let supportedCounts: ClosedRange<Int> = 0 ... maxPinCount
        
        var remainingPinsInExtendedRound = remainingPins
        let lastPin = rolls.last ?? 0
        
        if isExtendedRound {
            remainingPinsInExtendedRound = maxPinCount * 2
            
            if lastPin < 10 && !isSpare {
                remainingPinsInExtendedRound = maxPinCount - lastPin
            }
        }
        
        if supportedCounts.contains(downedPins) && (downedPins <= (isExtendedRound ? remainingPinsInExtendedRound : remainingPins)) {
            rolls += downedPins
            
            if isLastRound && (isSpare || isStrike) {
                isExtendedRound = true
            }
            
            if isStrike {
                print("Страйк!")
            } else {
                if isSpare && !isExtendedRound {
                    print("Спэр!")
                }
            }
            
            return true
        } else {
            let maxCount = min(supportedCounts.upperBound, isExtendedRound ? remainingPinsInExtendedRound : remainingPins)
            print("Количество сбитых кегель должно быть от \(supportedCounts.lowerBound) до \(maxCount), повторите ввод")
        }
        
        return false
    }
    
}
