//
//  GameProtocol.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 9/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation


protocol GameProtocol {
    
    var round: Int { get set }
    var roomID: String { get set }
    var players: [Player] { get set }
    var readyPlayers: Int { get set }
    var totalPlayers: Int { get }
    var isNowReadyForNextRound: Bool { get }
    var gameMode: GameMode { get set }
    var currentPlayer: Player { get }
    
    // TODO: Update these functions after we know exactly what they look like in the Game.swift file
//    func createGame(handler)
//    func joinGame()
//    func isReadyForNextRound() -> Bool
    
}

// MARK: Default Implementation
extension GameProtocol {
    
    var totalPlayers: Int { return players.count }
    var isNowReadyForNextRound: Bool { return readyPlayers == totalPlayers }
    
}

enum GameMode {
    
    case Drawing, Word
    
}