//
//  Game.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 9/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation

final class Game: GameProtocol {
    
    var round: Int = 0
    var roomID: String = String()
    var players: [Player] = []
    var readyPlayers: Int = 0
    var gameMode: GameMode = .Word
    var firebaseValue: AnyObject? { return createFirebaseValue() }
    var playerValues: NSDictionary { return createPlayerValues() }
    let currentPlayer: Player
    let gameAPI: GameAPIclient = GameAPIclient()
    
    init(currentPlayer: Player) {
        self.currentPlayer = currentPlayer
        gameAPI.game = self
        // TODO: Is this a reference cycle? Fix it.
        players.append(currentPlayer)
    }
    

    
}


// MARK: Creating a Game
extension Game {
    
    func createGame(handler: (success: Bool) -> Void) {
        gameAPI.createGame { success in
            dispatch_async(dispatch_get_main_queue(), { 
                handler(success: success)
            })
        }
    }
    
}


// MARK: Joining a Game
extension Game {
    
    func joinGame(withRoomID id: String, handler: (success: Bool, message: GameMessage) -> Void) {
        gameAPI.joinGame(withID: id) { success, message in
            dispatch_async(dispatch_get_main_queue(), { 
                handler(success: success, message: message)
            })
        }
    }
    
}


// MARK: Starting a Game
extension Game {
    
    func startGame(handler: (success: Bool) -> Void) {
        gameAPI.startTheGame { success in
            dispatch_async(dispatch_get_main_queue(), {
                handler(success: success)
            })
        }
    }
    
}

// MARK: Submitting A Word
extension Game {
    
    func submit(firstGuess guess: String, handler: (success: Bool, message: GameMessage) -> Void) {
        guard !guess.isEmpty else { handler(success: false, message: GameMessage.EmptyGuess(message: "Please make a guess.")); return }
        
        
        
        
        
        
    }
    
    
}


// MARK: Rounds
extension Game {
    
    func roundChanged(to round: Int) {
        print("Round changed method was called on the Game class to \(round)")
        switch round % 2 == 0 {
        case true:
            // Even rounds require that the person draw.
            print("Round is even.")
        case false:
            // Odd rounds require that the person create a word or phrase. The first round (round 1), requires that person create a word or phrase
            print("Round is odd.")
        }
        
    }
    
}


// MARK: Firebase
extension Game {
    
    func createFirebaseValue() -> AnyObject? {
        let result: AnyObject? = [
            "round" : round,
            "readyPlayers" : readyPlayers,
            "players" : playerValues
            ]
        return result
    }
    
    // TODO: This seems to only get called when a user first creates a room. That means there would only ever be one person available on creation of the room. We don't need to to loop through the players array, we can just commpute it for cunrrentPlayer. Does that seem right?
    func createPlayerValues() -> NSDictionary {
        var result: [String : NSDictionary] = [:]
        for player in players {
            result[player.playerID] = player.firebaseValue
        }
        return result
    }
    
}


enum RoundType {
    case Draw, Word
}
