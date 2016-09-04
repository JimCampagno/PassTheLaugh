//
//  Player.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 9/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation


final class Player {
    
    let playerID: String
    var word: String?
    var status: Status = .NotReady
    var guess: String?
    var drawingURL: String?
    var firebaseValue: NSDictionary { return createFirebaseValue() }
    
    init(playerID: String) {
        self.playerID = playerID
    }
    
}

// MARK: Firebase
extension Player {
    
    func createFirebaseValue() -> NSDictionary {
        return [
            "id" : playerID,
            "ready" : status.rawValue,
            "word" : word ?? "No Word",
            "guess" : guess ?? "No Guess",
            "drawingURL" : drawingURL ?? "No URL"
        ]
    }

    
}


enum Status: Int {
    
    case NotReady, Ready
    
}