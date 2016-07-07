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
    
    func getGames(onCompletion: ([OXGame]?, String?) -> Void) {
//        let onCompletion = {(gameArray: [OXGame]?, error: String?) in
//            {
//                
//            }
        return
    }
    
    func getGameList(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
                //remember a request has 4 things:
        //1: A endpoint
        //2: A method
        //3: input data (optional)
        //4: A response
    
        
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
        //we are now done with the registerUser function. Note that this function doesnt return anything. But because of the viewControllerCompletionFunction closure we are given as an input parameter, we can set in motion a function in the calling class when it is needed.
    }

}
