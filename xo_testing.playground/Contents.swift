//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class OXGame {
    
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
        if (turnCount() % 2 == 0) {
            return CellType.O
        }
        else {return CellType.X}
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

private var board = [CellType](count: 9, repeatedValue: CellType.Empty)

private var startType : CellType = CellType.X

var gameObject : OXGame = OXGame()

print(gameObject.CellType)

