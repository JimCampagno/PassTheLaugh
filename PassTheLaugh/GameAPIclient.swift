//
//  GameAPIclient.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 9/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import Firebase


final class GameAPIclient {
    
    let ref = FIRDatabase.database().reference()
    let storage = FIRStorage.storage()
    let storageRef = FIRStorage.storage().reference()
        
}


// MARK: Creation
extension GameAPIclient {
    
    func createGame() {
                
        for _ in (0..<14) {
            print(randomRoom())
        }
        
    }
    
     func randomRoom(inLength length: Int = 6) -> String {
        var result: String = String()
        
        for _ in 0..<length {
            let randomNumber = arc4random_uniform(9) + 1
            let randomNumberString = String(randomNumber)
            result += randomNumberString
        }
        
        return result
    }
    
}













