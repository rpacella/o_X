//
//  OXGameController.swift
//  o_X
//
//  Created by Riley Pacella on 6/29/16.
////  Copyright © 2016 iX. All rights reserved.

import Foundation

class OXGameController: WebService {
    static let sharedInstance = OXGameController()
    private var currentGame : OXGame
    
    override init() {
        currentGame = OXGame()
    }

    
    func getCurrentGame() -> OXGame {
        return currentGame
    }
    
    func restartGame() {
        currentGame.reset()
    }
    
    func playMove(cellNum: Int) -> CellType {
        return currentGame.playMove(cellNum)
    }
    
    func getGameList(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
        var gamesArray : [OXGame] = []
            
            
        if (responseCode == 200)   {
            for games in json.arrayValue {
                let game = OXGame()
                game.ID = games["id"].intValue
                game.host = games["host_user"]["uid"].stringValue
                gamesArray.append(game)
                }
            
                onCompletion(gamesArray, nil)
                
        }   else    {
                
            let errorMessage = json["errors"]["full_messages"][0].stringValue
            onCompletion(nil,errorMessage)
            }
        })
       
    }

    
    func joinGame(indexPath: Int, gameArray: [OXGame], onCompletion: (OXGame?, String?) -> Void) {
        
        
        let newGame = gameArray[indexPath]
        print(newGame.ID)
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(newGame.ID)/join"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            
            if (responseCode == 200)   {
                print("working")
                self.currentGame.ID = newGame.ID
                self.currentGame.host = newGame.host
            
                onCompletion(newGame, nil)
                
            }   else    {
                
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(nil, errorMessage)
            }
        })
        
    }

    func hostGame (onCompletion: (OXGame?, String?) -> Void) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200) {
                self.currentGame.ID = json["id"].intValue
                self.currentGame.host = json["host_user"]["uid"].stringValue
                onCompletion(self.currentGame, nil)
            }
            else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(nil,errorMessage)
            }
        })
    }

    func getGame (onCompletion: (OXGame?, String?)  -> Void) {
        let newGame = OXGameController.sharedInstance.currentGame
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(newGame.ID)"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200) {
                let updatedGame = OXGame()
                updatedGame.ID = json["id"].intValue
                updatedGame.host = json["host_user"]["uid"].stringValue
                updatedGame.board = OXGameController.sharedInstance.getCurrentGame().deserialiseBoard(json["board"].stringValue)
                OXGameController.sharedInstance.currentGame = updatedGame
                onCompletion(updatedGame, nil)
            }
            else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(nil,errorMessage)
            }
        })
    }
    
    func networkPlayMove(onCompletion: (String?)  -> Void) {
        let game = self.currentGame
        let string = game.serialiseBoard()
        let boardString = ["board":string]
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(game.ID)"), method: "PUT", parameters: boardString)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200) {
                onCompletion(nil)
            }
            else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(errorMessage)
            }
        })

    }
    
    func cancelGame(onCompletion: (String?) -> Void) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(self.currentGame.ID)"), method: "DELETE", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200) {
                self.currentGame.reset()
                onCompletion(nil)
            }
            else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(errorMessage)
            }
        })

    }
}