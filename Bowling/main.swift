//
//  main.swift
//  Bowling
//
//  Created by Egor Salnikov on 15.01.2021.
//

print("Добро пожаловать! Я Ваш личный боулинг менеджер. Введите число сбитых вами кеглей.")

let maxPinCount = 10
var isSecondRoll = false

var result: UInt = 0
var round = 0

func startGame() {
    while round < 10 {
        guard let input = readLine(), let downedPins = UInt(input) else {
            print("Введите корректное число сбитых кеглей")
            continue
        }
        
        let downedPinsInt = Int(downedPins)
        if (0 ... maxPinCount).contains(downedPinsInt) {
            handleRoll(downedPins)
        } else {
            print("Количество сбитых кеглей не может быть больше \(maxPinCount), повторите ввод")
        }
    }
}

func handleRoll(_ downedPins: UInt) {
    result += downedPins
    isSecondRoll = !isSecondRoll && downedPins < maxPinCount
    
    if isSecondRoll {
        print("Сделайте второй бросок")
    } else {
        round += 1
        outputResult()
    }
}

func outputResult() {
    let downedPins = String(result)
    
    switch result {
        case 0...10, 15...300:
            switch downedPins.last {
                case "1":
                    print("Вы сбили " + downedPins + " кеглю")
                case "2", "3", "4":
                    print("Вы сбили " + downedPins + " кегли")
                case "5", "6", "7", "8", "9", "0":
                    print("Вы сбили " + downedPins + " кеглей")
                default:
                    break
            }
        case 11 ... 14:
            print("Вы сбили " + downedPins + " кеглей")
        default:
            break
    }
    
    print("Следующий раунд! Ваш бросок...")
}

startGame()


