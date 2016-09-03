//
//  Game.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 9/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation


protocol Game {
    
    var round: Int { get set }
    var roomNumber: Int { get set }
    var players:  [Player] { get set }
    var readyPlayers: Int { get set }
    var nextRoundStatus: NextRoundStatus { get set }
    var totalPlayers: Int { get }
    var isNowReadyForNextRound: Bool { get }
    var gameMode: GameMode { get set }
    
    func createGame()
    func joinGame()
    func isReadyForNextRound() -> Bool
    
}

// MARK: Default Implementation
extension Game {
    
    var totalPlayers: Int { return players.count }
    var isNowReadyForNextRound: Bool { return readyPlayers == totalPlayers }
    
}

// MARK: Enumerations for Game Class
enum NextRoundStatus: Int {
    
    case Ready, NotReady
    
}

enum GameMode {
    
    case Drawing, Word
    
}