//
//  Round.swift
//  Bowling
//
//  Created by Egor Salnikov on 18.02.2021.
//

struct Round {
    
    private let maxPinCount = 10
    
    private(set) var rolls: [Int] = []
    
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
        return rolls.count == 2 || isStrike
    }
    
    // MARK: - Functions
    
    mutating func considerRoll(_ downedPins: Int) -> Bool {
        let supportedCounts: ClosedRange<Int> = 0 ... maxPinCount
        
        guard supportedCounts.contains(downedPins) && downedPins <= remainingPins else {
            print("Количество сбитых кегель должно быть от \(supportedCounts.lowerBound) до \(remainingPins), повторите ввод")
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
