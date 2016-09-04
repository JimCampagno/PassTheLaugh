//
//  GameAPIclient.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 9/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import Firebase

enum GameMessages {
    
    case NoGame(message: String)
    case GameIsFull(message: String)
    case Nothing
    
    
}


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
        // TODO: We need to generate an ID associated with each user. This should be done when they first sign-up to use the app, authorizing them.
        let playerID = "117996"
        let currentPlayer = Player(playerID: playerID)
        let game = Game(roomID: self.roomID, currentPlayer: currentPlayer)
        
        self.roomRef.child(self.roomID).setValue(game.firebaseValue, withCompletionBlock: { (error: NSError?, ref: FIRDatabaseReference) in
            // TODO: Handle Error here.
            dispatch_async(dispatch_get_main_queue(),{
                handler(success: true)
            })
        })
    }
    
}


// MARK: Joining

extension GameAPIclient {
    
    func joinGame(withID id: String, handler: (success: Bool, message: GameMessages) -> Void) {
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
        let currentPlayer = Player(playerID: "68149")
        roomRef.child(roomID).child("players").child(currentPlayer.playerID).setValue(currentPlayer.firebaseValue) { (error: NSError?, ref: FIRDatabaseReference) in
            // TODO: Handle Error here.
            dispatch_async(dispatch_get_main_queue(),{
                handler(success: true)
            })
        }
    }
    
}


// MARK: Live Gameplay

extension GameAPIclient {
    
    func createConnectionToRoom() {
        roomRef.child(roomID).observeEventType(.Value, withBlock: { snapshot in
            dispatch_async(dispatch_get_main_queue(), {
                print(snapshot.value) })
            }, withCancelBlock: { error in
                dispatch_async(dispatch_get_main_queue(), {
                    print(error.description)
                })
        })
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















