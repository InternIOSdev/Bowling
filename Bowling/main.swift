//
//  main.swift
//  Bowling
//
//  Created by Egor Salnikov on 15.01.2021.
//

import Foundation

print("Добро пожаловать! Я - Ваш личный боулинг менеджер. Введите число сбитых вами кеглей")

var result = 0
var round = 1

var secondRoll = false
var max = 10

var array: [String] = []

func userInput() {
    if let input = readLine() {
         if let inputInt = Int(input) {
            if validation(resultToValidate: inputInt) {
                result += inputInt
            }
         } else {
            print("Введите только число без пробелов")
         }
    }
}

func validation(resultToValidate: Int) -> Bool {
    if resultToValidate > 10 {
        return false
    } else {
        return true
    }
}

func outputResult() {
    print("Общее количество сбитых кеглей: \(result)")
    print(array)
}

func startGame() {
    while round <= 10 {
        guard let input = readLine(), let inputInt = Int(input) else {
            print("Введите только число без пробелов")
            continue
        }
        if validation(resultToValidate: inputInt) {
            if inputInt < max && secondRoll == false {
                print("Второй бросок")
                result += inputInt
                
                array.append(input)
                secondRoll = true
                
                continue
            }
            else if secondRoll == true {
                array.append(input)
                round += 1
                
                secondRoll = false
            }
            else {
                print("STRIKE")
                round += 1
                
                array.append(input)
            }
        } else {
            print("Количество сбитых кеглей не может быть больше 10")
        }
        outputResult()
    }
}

startGame()


