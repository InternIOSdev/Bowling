//
//  Array.swift
//  Bowling
//
//  Created by Egor Salnikov on 19.02.2021.
//

extension Array {
    
    // MARK: - Properties
    
    var penultimate: Element? {
        guard count >= 2 else {
            return nil
        }
        
        return self[count - 2]
    }
    
    // MARK: - Functions
    
    static func += (left: inout Self, right: Element) {
        left.append(right)
    }
    
}
