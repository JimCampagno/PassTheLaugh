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
    fileprivate var randomRoomID: String { roomID = randomRoom(); return roomID }
    fileprivate let lengthOfRoomNumber: Int = 6
    weak var game: GameProtocol!
    var gameStarted = false
    
}


// MARK: Creating

extension GameAPIclient {
    
    func createGame(handler: @escaping (Bool) -> Void) {
        
        doesGameExist(withID: randomRoomID, handler: { [unowned self] gameExists in
            
            switch gameExists {
            case true: self.createGame(handler: { handler($0) })
            case false: self.createRoomOnFirebase(handler: { handler($0) })
            }
            
        })
        
    }
    
    fileprivate func createRoomOnFirebase(handler: @escaping (Bool) -> Void) {
        
        roomRef.child(roomID).setValue(game.firebaseValue, withCompletionBlock: { [unowned self] error, ref in
            
            DispatchQueue.main.async {
                
                self.createConnectionToRoom(handler: { success in
                    
                    DispatchQueue.main.async {
                        
                        handler(true)
                        
                    }
                    
                })
                
            }
            
            
        })
        
    }
    
}


// MARK: Joining

extension GameAPIclient {
    
    func joinGame(withID id: String, handler: @escaping (Bool, GameMessage) -> Void) {
        roomID = id
        
        doesGameExist(withID: id, handler: { [unowned self] gameExists in
            
            DispatchQueue.main.async {
                
                switch gameExists {
                    
                case true: self.joinRoomOnFirebase(handler: { handler($0, .nothing) })
                case false: handler(false, .noGame(message: "Attempting to join game \(id), it doesn't exist. Please try again."))
                    
                }
                
            }
            
            
        })
        

    }
    
    fileprivate func joinRoomOnFirebase(handler: @escaping (Bool) -> Void) {
        
        roomRef.child(roomID).child("players").child(game.currentPlayer.playerID).setValue(game.currentPlayer.firebaseValue, withCompletionBlock: { [unowned self] error, ref in
            
            DispatchQueue.main.async {
                self.createConnectionToRoom(handler: { success in
                    DispatchQueue.main.async {
                        handler(success)
                    }
                })
            }
            
        })
        
    
    }
    
}


// MARK: Starting The Game

extension GameAPIclient {
    
    func startTheGame(handler: @escaping (Bool) -> Void) {
        
        roomRef.child(roomID).child("round").setValue(1, withCompletionBlock: { error, ref in
            
            DispatchQueue.main.async {
                handler(true)
            }
            
        })
        
       
    }
    
}


// MARK: Live Gameplay

extension GameAPIclient {
    
    // TODO: I feel like the Game class should have an instance property of type GameAPLIclient where this function gets called similar to how I'm doing it in the DrawViewController.swift file: After the sucess comes back on the joinGame method. Need to do the same for createGame method.
    func createConnectionToRoom(handler: @escaping (Bool) -> Void) {
        print("Calling on createConnection")
        
        roomRef.child(roomID).child("round").observe(.value, with: { [unowned self] snapshot in
            
            DispatchQueue.main.async {
                
                if !self.gameStarted { self.gameStarted = true; handler(true) }
                guard let roundValue = snapshot.value as? Int, roundValue != 0 else { return }
                self.game.roundChanged(to: roundValue)
                
            }
            
            
        })
        
      
        
        
        
    }
    
    func submit(guess: String, handler: (Bool, GameMessage) -> Void) {
        // TODO: What if this is the first guess they are making. It should be worded differently. Not Please make a guess.
        guard !guess.isEmpty else { handler(false, GameMessage.emptyGuess(message: "Please make a guess.")); return }
        
        // round1 : [player1 : [word : Mountains]],
        //          [player2 : [word : Truck]],
        //          [player3 : [word: Computer]]
        
        // round2 : [player1 : [wordToDraw : Computer, drawingURL: ""]],
        //          [player2 : [wordToDraw : Mountains, drawingURL : ""]],
        //          [player3 : [wordToDraw: Truck, drawingURL : ""]]
        
        // round3 : [player1 : [drawingToGuess : www.drawingblahblahabc2.com, guess: "Madonna"]],
        //          [player2 : [drawingToGuess : www.drawingblahblah2.com, guess: "Frodo"]],
        //          [player3 : [drawingToGuess : www.drawingblahblah323.com, guess: "Racecar Driver"]]
        
        
        
        // Room: Phil (A), Jim (B), Rebecca (C), Fred (D)
        
        //
        
        
        

    }
    
}


// MARK: Helper Functions

extension GameAPIclient {
    
    func doesGameExist(withID id: String, handler: @escaping (Bool) -> Void) {
        
        roomRef.child(id).observeSingleEvent(of: .value, with: { snapshot in
            
            DispatchQueue.main.async {
                handler(!(snapshot.value is NSNull))
            }
            
            
        })
    
    }
    
}


// MARK: Random Room ID Generator

extension GameAPIclient {
    
    fileprivate func randomRoom() -> String {
        var result: String = String()
        
        for _ in 0..<lengthOfRoomNumber {
            let randomNumber = arc4random_uniform(10)
            let randomNumberString = String(randomNumber)
            result += randomNumberString
        }
        
        return result
    }
    
}

