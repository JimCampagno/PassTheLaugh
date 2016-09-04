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
    var roomID: String
    var players: [Player] = []
    var readyPlayers: Int = 1
    var nextRoundStatus: NextRoundStatus = .NotReady
    var gameMode: GameMode = .Word
    var firebaseValue: AnyObject? { return createFirebaseValue() }
    var playerValues: NSDictionary { return createPlayerValues() }
    let currentPlayer: Player
    
    init(roomID: String, currentPlayer: Player) {
        self.roomID = roomID
        self.currentPlayer = currentPlayer
        // TODO: Is this a reference cycle? Fix it.
        players.append(currentPlayer)
    }
    
    // TODO: Implement these methods. Have them work with the GameAPIClient?
    func createGame() { }
    func joinGame() { }
    func isReadyForNextRound() -> Bool { return false }
    
}


// MARK: Firebase

extension Game {
    
    func createFirebaseValue() -> AnyObject? {
        let result: AnyObject? = [
            "round" : round,
            "ready" : nextRoundStatus.rawValue,
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