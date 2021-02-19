//
//  main.swift
//  Bowling
//
//  Created by Egor Salnikov on 15.01.2021.
//

private let numberOfRounds = 10

private var history: [Round] = []
private var totalResult = 0

private var currentRound = Round()

// MARK: - Runtime

print("Добро пожаловать! Я Ваш личный боулинг-менеджер. Введите число сбитых вами кегель.")
startGame()

// MARK: - Functions

func startGame() {
    while history.count < numberOfRounds {
        guard let input = readLine(), let downedPins = Int(input) else {
            print("Введите корректное число сбитых кегель")
            continue
        }
        
        if currentRound.considerRoll(downedPins) {
            if let previousRound = history.last {
                let isFirstRollNow = currentRound.rolls.count == 1
                
                if previousRound.isStrike {
                    totalResult += downedPins
                    
                    if history.penultimate?.isStrike == true && isFirstRollNow {
                        totalResult += downedPins
                    }
                } else {
                    if previousRound.isSpare, isFirstRollNow {
                        totalResult += downedPins
                    }
                }
            }
            
            if currentRound.isFinished {
                totalResult += currentRound.brokenPins
                startNextRound()
            } else {
                print("Сделайте ещё один бросок")
            }
        }
    }
}

func startNextRound() {
    history += currentRound
    currentRound = Round()
    
    outputResult()
}

func outputResult() {
    let wordForms = WordForms(one: "очко", three: "очка", many: "очков")
    let count = String(forCount: totalResult, wordForms: wordForms)
    
    if history.count == numberOfRounds {
        print("Игра закончена! Поздравляем, вы набрали \(count).")
    } else {
        print("Следующий раунд! Ваш бросок...")
    }
}
