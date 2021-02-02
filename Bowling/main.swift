//
//  main.swift
//  Bowling
//
//  Created by Egor Salnikov on 15.01.2021.
//

import Foundation

typealias WordForms = (one: String, three: String, many: String)

print("Добро пожаловать! Я Ваш личный боулинг-менеджер. Введите число сбитых вами кегель.")

let maxPinCount = 10
var isSecondRoll = false

var firstRollCount = 0
var totalPinCount = 0

var totalResult = 0
var round = 0

var history: [[Int]] = []

func startGame() {
    while round < 10 {
        guard let input = readLine(), let downedPins = Int(input) else {
            print("Введите корректное число сбитых кегель")
            continue
        }
        
        let supportedCounts: ClosedRange<Int> = 0 ... 10
        let remainingPins = maxPinCount - firstRollCount
        
        if supportedCounts.contains(downedPins) && downedPins <= remainingPins {
            handleRoll(downedPins)
        } else {
            let maxCount = min(supportedCounts.upperBound, remainingPins)
            print("Количество сбитых кегель должно быть от \(supportedCounts.lowerBound) до \(maxCount), повторите ввод")
        }
    }
}

func handleRoll(_ downedPins: Int) {
    isSecondRoll = !isSecondRoll && downedPins < maxPinCount
    
    if isSecondRoll {
        firstRollCount = downedPins
        print("Сделайте второй бросок")
    } else {
        totalPinCount = firstRollCount + downedPins
        handleSpareOrStrike()
        
        if downedPins == maxPinCount {
            history += [[downedPins]]
        } else {
            history += [[firstRollCount, downedPins]]
        }
        firstRollCount = 0
        
        totalResult += totalPinCount
        round += 1
        
        outputResult()
    }
}

func handleSpareOrStrike() {
    let lastPin = history.last ?? []
    let penultimatePin = history.penultimate() ?? []
    
    if lastPin.count == 1 && lastPin.reduce(0, +) == maxPinCount || penultimatePin.count == 1 && penultimatePin.reduce(0, +) == maxPinCount {
        totalPinCount *= 2
    }
    
    if lastPin.count == 2 && lastPin.reduce(0, +) == maxPinCount {
        totalPinCount *= 2
    }
}

func outputResult() {
    let wordForms = WordForms(one: "кеглю", three: "кегли", many: "кегель")
    
    guard let count = String(count: totalResult, wordForms: wordForms) else {
        return
    }
    
    if round == 10 {
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
    
  func penultimate() -> Element? {
      if self.count < 2 {
          return nil
      }
    
      let index = self.count - 2
      return self[index]
  }
}
