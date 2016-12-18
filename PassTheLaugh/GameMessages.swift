//
//  GameMessages.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 9/4/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation


enum GameMessage {
    
    case noGame(message: String)
    case gameIsFull(message: String)
    case emptyGuess(message: String)
    case nothing
    
}
