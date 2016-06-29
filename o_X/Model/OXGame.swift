//
//  OXGame.swift
//  o_X
//
//  Created by Riley Pacella on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation



enum CellType : String {
    
    case O = "O"
    case X = "X"
    case Empty = ""
    
}

enum OXGameState {
    case InProgress
    case Tie
    case Wone
}

var board = [CellType](count: 9, repeatedValue: CellType.Empty)

var startType : CellType = CellType.X

func turnCount() -> Int {
    var i : Int = 0, count : Int = 9
    while i < 9 {
        if (board[i] == "") {
            count -= 1
        }
    }
    return count
}

func whoseTurn() -> CellType {
    turn = turnCount()
    if (turn == 1 || 3 || 5 || 7) {
        return CellType.X
    }
    else {return CellType.O}
}

func playMove(cellNum : Int) -> CellType {
    player = whoseTurn()
    board[cellNum] = player
    return player
    
}
