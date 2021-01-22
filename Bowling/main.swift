//
//  main.swift
//  Bowling
//
//  Created by Egor Salnikov on 15.01.2021.
//

print("Добро пожаловать! Я Ваш личный боулинг менеджер. Введите число сбитых вами кеглей.")

let maxPinCount = 10
var isSecondRoll = false

var result = 0
var round = 0

func startGame() {
    while round < 10 {
        guard let input = readLine(), let inputInt = Int(input) else {
            print("Введите только число без пробелов")
            continue
        }
        if checkValidPinCount(inputInt) {
            if isSecondRollNow(isSecondRoll, inputInt) {
                isSecondRoll = true
                
                continue
            } else {
                isSecondRoll = false
                
            }
        } else {
            print("Количество сбитых кеглей не может быть больше 10")
        }
        outputResult()
    }
}

func checkValidPinCount(_ value: Int) -> Bool {
    return (0...10).contains(value)
}

func outputResult() {
    print("Общее количество сбитых кеглей: " + String(result))
    print("Следующий ход! Ваш бросок: ")
}

func isSecondRollNow(_ isSecondaryRoll: Bool, _ countPin: Int) -> Bool {
    if countPin < maxPinCount && isSecondaryRoll == false {
        result += countPin
        print("Второй бросок")
        
        return true
    } else {
        result += countPin
        round += 1

        return false
    }
}

startGame()


