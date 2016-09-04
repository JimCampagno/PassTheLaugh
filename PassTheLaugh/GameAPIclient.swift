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
    
    var roomRef = FIRDatabase.database().reference().child("rooms")
    let storage = FIRStorage.storage()
    let storageRef = FIRStorage.storage().reference()
    var roomID: String = String()
    private var randomRoomID: String { roomID = randomRoom(); return roomID }
    private let lengthOfRoomNumber: Int = 6
    
}


// MARK: Creating

extension GameAPIclient {
    
    func createGame(handler: (success: Bool) -> Void) {
        roomRef.child(randomRoomID).observeSingleEventOfType(.Value) { [unowned self] (snap: FIRDataSnapshot) in
            if snap.value is NSNull {
                // TODO: We need to generate an ID associated with each user. This should be done when they first sign-up to use the app, authorizing them.
                let playerID = "117996"
                let currentPlayer = Player(playerID: playerID)
                let game = Game(roomID: self.roomID, currentPlayer: currentPlayer)
                
                self.roomRef.child(self.roomID).setValue(game.firebaseValue, withCompletionBlock: { (error: NSError?, ref: FIRDatabaseReference) in
                    print("This is error: \(error)")
                    print("This is the ref: \(ref)")
                    
                    handler(success: true)
                })
                
            } else {
                // TODO: If a game already exists, we enter this else block. I'm calling on the function again. This should be cleaned up.
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.createGame { success in
                        handler(success: success)
                    }
                }
            }
        }
        
    }
    
    private func createRoom(withNumber number: String) {
        
    }

}


// MARK: Joining

extension GameAPIclient {
    
    func joinRoom(withID id: String, handler: (success: Bool) -> Void) {
        
        
        
    }
    
    
    
}


// MARK: Random Generator

extension GameAPIclient {
    
    private func randomRoom() -> String {
        var result: String = String()
        
        for _ in 0..<lengthOfRoomNumber {
            let randomNumber = arc4random_uniform(9) + 1
            let randomNumberString = String(randomNumber)
            result += randomNumberString
        }
        
        return result
    }
    
}













