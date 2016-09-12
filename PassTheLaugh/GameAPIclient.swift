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
    weak var game: GameProtocol!
    var gameStarted = false
    
}


// MARK: Creating

extension GameAPIclient {
    
    func createGame(handler: (success: Bool) -> Void) {
        doesGameExist(withID: randomRoomID) { [unowned self] gameExists in
            dispatch_async(dispatch_get_main_queue(),{
                switch gameExists {
                case true: self.createGame { handler(success: $0) }
                case false: self.createRoomOnFirebase { handler(success: $0) }
                }
            })
        }
    }
    
    private func createRoomOnFirebase(handler: (success: Bool) -> Void) {
        self.roomRef.child(self.roomID).setValue(game.firebaseValue, withCompletionBlock: { [unowned self] (error: NSError?, ref: FIRDatabaseReference) in
            dispatch_async(dispatch_get_main_queue(),{
                self.createConnectionToRoom { success in
                    dispatch_async(dispatch_get_main_queue(), {
                        handler(success: true)
                    })
                }
            })
            })
    }
    
}


// MARK: Joining

extension GameAPIclient {
    
    func joinGame(withID id: String, handler: (success: Bool, message: GameMessage) -> Void) {
        roomID = id
        doesGameExist(withID: id) { [unowned self] gameExists in
            dispatch_async(dispatch_get_main_queue(),{
                switch gameExists {
                // TODO: With the true case, we're not checking to see if the game is full. Can it be full? I haven't decided how that works yet.
                case true: self.joinRoomOnFirebase { handler(success: $0, message: .Nothing) }
                case false: handler(success: false, message: .NoGame(message: "Attempting to join game \(id), it doesn't exist. Please try again."))
                }
            })
        }
    }
    
    private func joinRoomOnFirebase(handler: (success: Bool) -> Void) {
        roomRef.child(roomID).child("players").child(game.currentPlayer.playerID).setValue(game.currentPlayer.firebaseValue) { [unowned self] (error: NSError?, ref: FIRDatabaseReference) in
            // TODO: Handle Error here.
            dispatch_async(dispatch_get_main_queue(),{
                self.createConnectionToRoom { success in
                    dispatch_async(dispatch_get_main_queue(), {
                        handler(success: success)
                    })
                }
            })
        }
    }
    
}


// MARK: Starting The Game

extension GameAPIclient {
    
    func startTheGame(handler: (success: Bool) -> Void) {
        roomRef.child(roomID).child("round").setValue(1) { (error: NSError?, ref: FIRDatabaseReference) in
            dispatch_async(dispatch_get_main_queue(), {
                // TODO: Handle Error case here.
                handler(success: true)
            })
        }
    }
    
}


// MARK: Live Gameplay

extension GameAPIclient {
    
    // TODO: I feel like the Game class should have an instance property of type GameAPLIclient where this function gets called similar to how I'm doing it in the DrawViewController.swift file: After the sucess comes back on the joinGame method. Need to do the same for createGame method.
    func createConnectionToRoom(handler: (success: Bool) -> Void) {
        print("Calling on createConnection")
        roomRef.child(roomID).child("round").observeEventType(.Value, withBlock: { [unowned self] snapshot in
            dispatch_async(dispatch_get_main_queue(), {
                if !self.gameStarted { self.gameStarted = true; handler(success: true) }
                guard let roundValue = snapshot.value as? Int where roundValue != 0 else { return }
                self.game.roundChanged(to: roundValue)
            })
            }, withCancelBlock: { error in
                dispatch_async(dispatch_get_main_queue(), {
                    print(error.description)
                })
        })
    }
    
    func submit(guess guess: String, handler: (success: Bool, message: GameMessage) -> Void) {
        // TODO: What if this is the first guess they are making. It should be worded differently. Not Please make a guess.
        guard !guess.isEmpty else { handler(success: false, message: GameMessage.EmptyGuess(message: "Please make a guess.")); return }
        
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
        
        
        
        

        
        

        
        
        
        
        
        
        
    }
    
}


// MARK: Helper Functions

extension GameAPIclient {
    
    func doesGameExist(withID id: String, handler: (gameExists: Bool) -> Void) {
        roomRef.child(id).observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in
            dispatch_async(dispatch_get_main_queue(),{
                handler(gameExists: !(snap.value is NSNull))
            })
        }
    }
    
}


// MARK: Random Room ID Generator

extension GameAPIclient {
    
    private func randomRoom() -> String {
        var result: String = String()
        
        for _ in 0..<lengthOfRoomNumber {
            let randomNumber = arc4random_uniform(10)
            let randomNumberString = String(randomNumber)
            result += randomNumberString
        }
        
        return result
    }
    
}

