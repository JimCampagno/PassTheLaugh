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
    var readyPlayers: Int = 0
    var nextRoundStatus: NextRoundStatus = .NotReady
    var gameMode: GameMode = .Word
    var firebaseValue: AnyObject? { return createFirebaseValue() }
    var playerValues: [NSDictionary] { return createPlayerValues() }
    let currentPlayer: Player
    
    init(roomID: String, currentPlayer: Player) {
        self.roomID = roomID
        self.currentPlayer = currentPlayer
        
        // TODO: Is this a reference cycle? Fix it.
        players.append(currentPlayer)
    }
    
    func createGame() {
        
    }
    
    func joinGame() {
        
    }
    
    func isReadyForNextRound() -> Bool {
        return false
    }
    
    
   
    
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
    
    func createPlayerValues() -> [NSDictionary] {
        return players.map { $0.firebaseValue }
    }
    
}