//
//  main.swift
//  Bowling
//
//  Created by Egor Salnikov on 15.01.2021.
//

import Foundation

struct Round {
    
    var firstRollCount = 0
    
    var strike = false
    var spare = false
    
    var secondRoll = false
    var pins: [Int] = []
}

typealias WordForms = (one: String, three: String, many: String)

print("Добро пожаловать! Я Ваш личный боулинг-менеджер. Введите число сбитых вами кегель.")

let maxPinCount = 10
var totalResult = 0

var history: [Round] = []
var roundCount = 0

var round = Round()

func startGame() {
    while roundCount < 10 {
        guard let input = readLine(), let downedPins = Int(input) else {
            print("Введите корректное число сбитых кегель")
            continue
        }
        
        let supportedCounts: ClosedRange<Int> = 0 ... 10
        let remainingPins = maxPinCount - round.firstRollCount
        
        if supportedCounts.contains(downedPins) && downedPins <= remainingPins {
            handleRoll(downedPins)
        } else {
            let maxCount = min(supportedCounts.upperBound, remainingPins)
            print("Количество сбитых кегель должно быть от \(supportedCounts.lowerBound) до \(maxCount), повторите ввод")
        }
    }
}

func handleRoll(_ downedPins: Int) {
    round.secondRoll = !round.secondRoll && downedPins < maxPinCount

    if round.secondRoll {
        round.firstRollCount = downedPins
        print("Сделайте второй бросок")
    } else {
        var totalPinCount = round.firstRollCount + downedPins
        checkSpareAndStrike()
        
        if round.strike {
            history.last?.pins.count == 1 && history.penultimate?.pins.count == 1 ? (totalPinCount *= 3) : (totalPinCount *= 2)
        }
            
        if round.spare {
            totalPinCount *= 2
        }
        
        if downedPins == maxPinCount {
            round.pins.append(downedPins)
            history.append(round)
        } else {
            round.pins += [round.firstRollCount, downedPins]
            history.append(round)
        }
        
        round.firstRollCount = 0
        
        totalResult += totalPinCount
        roundCount += 1
        
        print(round.pins)
        outputResult()
    }
}

func checkSpareAndStrike() {
    if (history.last?.pins.count == 1) || (history.penultimate?.pins.count == 1) {
        round.strike = true
    }
    
    if (history.last?.pins.count == 2) && (history.last?.pins.reduce(0, +) == maxPinCount) {
        round.spare = true
    }
}

func outputResult() {
    let wordForms = WordForms(one: "кеглю", three: "кегли", many: "кегель")
    
    guard let count = String(count: totalResult, wordForms: wordForms) else {
        return
    }
    
    if roundCount == 10 {
        print("Игра закончена! Поздравляем, вы сбили " + count)
    } else {
        print("Следующий раунд! Ваш бросок...")
    }
}

startGame()

extension String {
    
    init?(count: Int, wordForms: WordForms) {
        var suitableForm = wordForms.many
        
        if count.getDigit(ofRank: 10) != 1 {
            switch count.getDigit(ofRank: 1) {
                case 1:
                    suitableForm = wordForms.one
                case 2, 3, 4:
                    suitableForm = wordForms.three
                
                default:
                    break
            }
        }
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        
        formatter.groupingSize = 3
        formatter.groupingSeparator = "\u{202F}"
        
        guard let digits = formatter.string(for: count) else {
            return nil
        }
        
        self = "\(digits)\u{00A0}\(suitableForm)"
    }
    
}

extension Int {
    
    func getDigit(ofRank rank: Int) -> Int? {
        guard rank > 0 && rank <= self && (rank.isMultiple(of: 10) || rank == 1) else {
            return nil
        }
        
        let multiplier = rank * 10
        return Int(self / rank) - Int(self / multiplier) * 10
    }
    
}

extension Array {
    
    var penultimate: Element? {
        return count >= 2 ? self[count - 2] : nil
    }
    
}

