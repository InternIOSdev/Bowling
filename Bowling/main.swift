//
//  main.swift
//  Bowling
//
//  Created by Egor Salnikov on 15.01.2021.
//

import Foundation

print("Добро пожаловать! Я - Ваш личный боулинг менеджер. Введите число сбитых вами кеглей")

var isPlaying = false
var result = 0

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
        print("Количество сбитых кеглей не может быть больше 10, введите корректное число")
        return false
    } else {
        return true
    }
}

func outputResult() {
    print("Общее количество сбитых кеглей: \(result)")
}

func startGame() {
    while !isPlaying {
        userInput()
        outputResult()
    }
}

startGame()
