//
//  PassGenerator.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 13/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import Foundation

class PassGenerator {
    
    let listOfWords: [String] = ["morsel", "level", "junior", "monkey", "joy", "cut", "face", "mention", "cart", "observer",
                                 "effect", "dump", "retailer", "slipper", "sleep", "weight", "principle", "body", "twilight", "adoption", "joke", "squirrel", "country", "curve", "sticky", "comedy", "avenue", "haunt", "people"]
    
    func randomPassCode() -> String {
        
        let randomIndex = Int(arc4random_uniform(UInt32(listOfWords.count)))
        let randomPass = listOfWords[randomIndex] + "\(randomNumber(with: 4) ?? 0000)"
        
        return randomPass
    }
    
    func randomNumber(with digit: Int) -> Int? {
        
        guard 0 < digit, digit < 20 else { // 0 digit number don't exist and 20 digit Int are to big
            return nil
        }
        
        /// The final ramdom generate Int
        var finalNumber : Int = 0;
        
        for i in 1...digit {
            
            /// The new generated number which will be add to the final number
            var randomOperator : Int = 0
            
            repeat {
                #if os(Linux)
                randomOperator = Int(random() % 9) * Int(powf(10, Float(i - 1)))
                #else
                randomOperator = Int(arc4random_uniform(9)) * Int(powf(10, Float(i - 1)))
                #endif
                
            } while Double(randomOperator + finalNumber) > Double(Int.max) // Verification to be sure to don't overflow Int max size
            
            finalNumber += randomOperator
        }
        
        return finalNumber
    }
}
