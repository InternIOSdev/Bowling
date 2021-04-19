//
//  Round.swift
//  Bowling
//
//  Created by Egor Salnikov on 18.02.2021.
//

struct Round {
    
    private let maxPinCount = 10
    
    private(set) var rolls: [Int] = []
    var isExtended = false
    
    // MARK: - Properties
    
    var brokenPins: Int {
        return rolls.reduce(0, +)
    }
    
    var remainingPins: Int {
        return maxPinCount - brokenPins
    }
    
    var isSpare: Bool {
        return remainingPins == 0 && rolls.count == 2
    }
    
    var isStrike: Bool {
        return remainingPins == 0 && rolls.count == 1
    }
    
    var isFinished: Bool {
        if isExtended {
            return rolls.count == 3 
        } else {
            return rolls.count == 2 || isStrike
        }
    }
    
    // MARK: - Functions
    
    mutating func considerRoll(_ downedPins: Int) -> Bool {
        let supportedCounts: ClosedRange<Int> = 0 ... maxPinCount
        
        var remainingPinsInExtendedRound = remainingPins + maxPinCount
        let lastPin = rolls.last ?? 0

        if lastPin == maxPinCount && rolls.count == 2 {
            remainingPinsInExtendedRound += maxPinCount
        }
        
        if isExtended && lastPin < maxPinCount && !isSpare {
            remainingPinsInExtendedRound = maxPinCount - lastPin
        }
        
        guard supportedCounts.contains(downedPins) && (downedPins <= (!isExtended ? remainingPins : remainingPinsInExtendedRound)) else {
            print("Количество сбитых кегель должно быть от \(supportedCounts.lowerBound) до \(isExtended ? remainingPinsInExtendedRound : remainingPins), повторите ввод")
            return false
        }
        
        rolls += downedPins
        
        if isSpare {
            print("Спэр!")
        } else {
            if isStrike {
                print("Страйк!")
            }
        }
        
        return true
    }
    
}
