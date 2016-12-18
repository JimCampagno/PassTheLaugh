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
    var gameMode: GameMode = .word
    var firebaseValue: [String : Any]? { return createFirebaseValue() }
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
    
    func createGame(_ handler: @escaping (_ success: Bool) -> Void) {
        gameAPI.createGame { success in
            DispatchQueue.main.async(execute: { 
                handler(success)
            })
        }
    }
    
}


// MARK: Joining a Game
extension Game {
    
    func joinGame(withRoomID id: String, handler: @escaping (_ success: Bool, _ message: GameMessage) -> Void) {
        gameAPI.joinGame(withID: id) { success, message in
            DispatchQueue.main.async(execute: { 
                handler(success, message)
            })
        }
    }
    
}


// MARK: Starting a Game
extension Game {
    
    func startGame(_ handler: @escaping (_ success: Bool) -> Void) {
        gameAPI.startTheGame { success in
            DispatchQueue.main.async(execute: {
                handler(success)
            })
        }
    }
    
}

// MARK: Submitting A Word
extension Game {
    
    func submit(firstGuess guess: String, handler: (_ success: Bool, _ message: GameMessage) -> Void) {
        guard !guess.isEmpty else { handler(false, GameMessage.emptyGuess(message: "Please make a guess.")); return }
        
        
        
        
        
        
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
    
    func createFirebaseValue() -> [String : Any]? {
        let result: [String : Any]? = [
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
        return result as NSDictionary
    }
    
}


enum RoundType {
    case draw, word
}
