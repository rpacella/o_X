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
    case Won
}

//model class for OXGame
class OXGame {

    private var board = [CellType](count: 9, repeatedValue: CellType.Empty)
    private var startType : CellType = CellType.X
    
//turnCount

func turnCount() -> Int {
    var i : Int = 0, count : Int = 0
    while i < 9 {
        if (board[i] != CellType.Empty) {
            count += 1
        }
        i += 1
    }
    return count
}


//Whose turn

func whoseTurn() -> CellType {
    if (turnCount() % 2 == 0) {
        return CellType.O
    }
    else {return CellType.X}
}

//playMove
    
func playMove(cellNum : Int) -> CellType {
    board[cellNum] = whoseTurn()
    return whoseTurn()
    
}

//Game Won
func gameWon() -> Bool {
    
    //top bar
    if ( (board[0] == board[1]) && (board[1] == board[2]) ) {
        if (board[0] != CellType.Empty) {
            return true
        }
        else {return false}
    }
    
    //first column
    if ( (board[0] == board[3]) && (board[3] == board[6]) ) {
        if (board[0] != CellType.Empty) {
            return true
        }
        else {return false}
    }
    
    //second column
    if ( (board[1] == board[4]) && (board[1] == board[7]) ) {
        if (board[1] != CellType.Empty) {
            return true
        }
        else {return false}
    }
    //third column
    if ( (board[2] == board[5]) && (board[2] == board[8]) ) {
        if (board[2] != CellType.Empty) {
            return true
        }
        else {return false}
    }
    
    //second row
    if ( (board[3] == board[4]) && (board[4] == board[5]) ) {
        if (board[3] != CellType.Empty) {
            return true
        }
        else {return false}
    }

    //third row
    if ( (board[6] == board[7]) && (board[7] == board[8]) ) {
        if (board[7] != CellType.Empty) {
            return true
        }
        else {return false}
    }
    
    //first diag
    if ( (board[0] == board[4]) && (board[4] == board[8]) ) {
        if (board[0] != CellType.Empty) {
            return true
        }
        else {return false}
    }
    
    //second diag
    if ( (board[2] == board[4]) && (board[4] == board[6]) ) {
        if (board[2] != CellType.Empty) {
            return true
        }
        else {return false}
    }
    else {return false}
    }


//    if ((board[0], board[1]) == (board[0], board[2]) && (board[0] != CellType.Empty) ||
//        (board[3], board[4]) == (board[3], board[5]) && (board[3] != CellType.Empty) ||
//        (board[6], board[7]) == (board[6], board[8]) && (board[6] != CellType.Empty) ||
//        (board[0], board[3]) == (board[0], board[6]) && (board[0] != CellType.Empty) ||
//        (board[1], board[4]) == (board[1], board[7]) && (board[1] != CellType.Empty) ||
//        (board[2], board[4]) == (board[3], board[5]) && (board[2] != CellType.Empty) )
 

//State of game
    
func state() -> OXGameState {
    if (gameWon() == true) {
        return OXGameState.Won
    }
    if (gameWon() == false && turnCount() == 9) {
        return OXGameState.Tie
    }
    else { return OXGameState.InProgress }
}

//Reset game
    
func reset() {
    board = [CellType](count: 9, repeatedValue: CellType.Empty)
    
}
     init()  {
        
        //we are simulating setting our board from the internet
        let simulatedBoardStringFromNetwork = "o________" //update this string to different values to test your model serialisation
        self.board = deserialiseBoard(simulatedBoardStringFromNetwork) //your OXGame board model should get set here
        if(simulatedBoardStringFromNetwork == serialiseBoard())    {
            print("start\n------------------------------------")
            print("congratulations, you successfully deserialised your board and serialized it again correctly. You can send your data model over the internet with this code. 1 step closer to network OX ;)")
            
            print("done\n------------------------------------")
        }   else    {
            print("start\n------------------------------------")
            print ("your board deserialisation and serialization was not correct :( carry on coding on those functions")
            
            print("done\n------------------------------------")
        }
        
    }
    
    private func deserialiseBoard(boardString : String) -> [CellType]{
        var boardArray : [CellType] = []

        for char in Array(arrayLiteral: boardString) {
            if char == "o" {
                boardArray.append(CellType.O)
            }
            if char == "x" {
                boardArray.append(CellType.X)
            }
            else {
                boardArray.append(CellType.Empty)
            }
        }
        return boardArray
    }
    
    private func serialiseBoard() -> String {
        var boardString : String = ""
        for char in self.board {
            if char == CellType.O {
                boardString += "o"
            }
            if char == CellType.X {
                boardString += "x"
            }
            else {
                boardString += "_"
            }
        }
        return boardString
    }

}