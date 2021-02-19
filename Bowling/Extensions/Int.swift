//
//  Int.swift
//  Bowling
//
//  Created by Egor Salnikov on 19.02.2021.
//

extension Int {
    
    func getDigit(ofRank rank: Int) -> Int? {
        guard rank > 0 && rank <= self, rank.isMultiple(of: 10) || rank == 1 else {
            return nil
        }
        
        let multiplier = rank * 10
        return Int(self / rank) - Int(self / multiplier) * 10
    }
    
}
