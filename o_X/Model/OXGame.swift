//
//  OXGame.swift
//  o_X
//
//  Created by Riley Pacella on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGame {

enum CellType : String {
    
    case O = "O"
    case X = "X"
    case Empty = ""
    
}

enum OXGameState {
    case InProgress
    case Tie
    case Won
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
    if (turnCount() == 1 || 3 || 5 || 7) {
        return CellType.X
    }
    else {return CellType.O}
}

func playMove(cellNum : Int) -> CellType {
    board[cellNum] = whoseTurn()
    return whoseTurn()
    
}

func gameWon() -> Bool {
    if (((board[0], board[1] == board[0], board[2]) && board[0] != CellType.Empty) ||
        ((board[3], board[4] == board[3], board[5]) && board[3] != CellType.Empty) ||
        ((board[6], board[7] == board[6], board[8]) && board[6] != CellType.Empty) ||
        ((board[0], board[3] == board[0], board[6]) && board[0] != CellType.Empty) ||
        ((board[1], board[4] == board[1], board[7]) && board[1] != CellType.Empty) ||
        ((board[2], board[4] == board[3], board[5]) && board[2] != CellType.Empty) )
    {
        return true
    }
    
    else {return false}
}

func state() -> OXGameState {
    if (gameWon() == true) {
        return OXGameState.Won
    }
    if (gameWon() == false && turnCount() == 9) {
        return OXGameState.Tie
    }
    else { return OXGameState.InProgress }
}

func reset() {
    board = [CellType](count: 9, repeatedValue: CellType.Empty)
    
}

}