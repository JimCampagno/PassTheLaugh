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
    var nextRoundStatus: NextRoundStatus { get set }
    var totalPlayers: Int { get }
    var isNowReadyForNextRound: Bool { get }
    var gameMode: GameMode { get set }
    var currentPlayer: Player { get }
    
    func createGame()
    func joinGame()
    func isReadyForNextRound() -> Bool
    
}

// MARK: Default Implementation
extension GameProtocol {
    
    var totalPlayers: Int { return players.count }
    var isNowReadyForNextRound: Bool { return readyPlayers == totalPlayers }
    
}


enum NextRoundStatus: Int {
    
    case NotReady, Ready
    
}

enum GameMode {
    
    case Drawing, Word
    
}