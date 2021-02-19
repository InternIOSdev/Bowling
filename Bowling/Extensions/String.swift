//
//  String.swift
//  Bowling
//
//  Created by Egor Salnikov on 19.02.2021.
//

extension String {
    
    init(forCount count: Int, wordForms: WordForms) {
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
        
        self = "\(count) \(suitableForm)"
    }
    
}
