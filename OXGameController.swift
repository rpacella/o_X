//
//  OXGameController.swift
//  o_X
//
//  Created by Riley Pacella on 6/29/16.
////  Copyright © 2016 iX. All rights reserved.

import Foundation

class OXGameController {
    static let sharedInstance = OXGameController()
    private var currentGame : OXGame
    
    init() {
        currentGame = OXGame()
    }
    
    var ID: Int = 0
    var host: String  = ""

    
    func getCurrentGame() -> OXGame {
        return currentGame
    }
    
    func restartGame() {
        currentGame.reset()
    }
    
    func playMove(cellNum: Int) {
        currentGame.playMove(cellNum)
    }
    
    func getGames(onCompletion: ([OXGame]?, String?) -> Void) {
        //Return dummy data
    }
}


